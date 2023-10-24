// ignore_for_file: library_private_types_in_public_api

import 'package:carx/components/rating_bar_widget.dart';
import 'package:carx/components/reviews_car.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/car_detail.dart';
import 'package:carx/data/model/detail.dart';
import 'package:carx/data/model/distributor_model.dart';
import 'package:carx/features/car_detail/bloc/detail_bloc.dart';
import 'package:carx/features/car_detail/bloc/detail_event.dart';
import 'package:carx/features/car_detail/bloc/detail_state.dart';
import 'package:carx/service/api/reponsitory/car_reponsitory.dart';

import 'package:carx/features/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CarDetailView extends StatefulWidget {
  const CarDetailView({Key? key}) : super(key: key);

  @override
  _CarDetailViewState createState() => _CarDetailViewState();
}

class _CarDetailViewState extends State<CarDetailView> {
  late CarDetailBloc carDetailBloc;

  @override
  void initState() {
    carDetailBloc = CarDetailBloc(CarReponsitory.response());
    super.initState();
  }

  @override
  void dispose() {
    carDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Car carr = ModalRoute.of(context)!.settings.arguments as Car;
    return BlocBuilder<CarDetailBloc, CarDetailState>(
      bloc: carDetailBloc..add(FetchCarDetailEvent(car: carr)),
      builder: (context, state) {
        if (state is CarDetailLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CarDetailSuccess) {
          final Detail detail = state.detail;
          final CarDetail car = detail.carDetail;
          final DistributorModel distributorModel = detail.distributorModel;
          return Scaffold(
            bottomNavigationBar: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x1A000000),
                    offset: Offset(0, -2),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${car.pricePerDay}/day',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '14% off',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderView(),
                          settings: RouteSettings(arguments: carr)));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.amber[100],
                      fixedSize: const Size(130, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      side: const BorderSide(width: 1, color: Colors.amber),
                    ),
                    child: const Text(
                      'Book now',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.cyan[100],
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      'assets/images/xcar-full-black.png'),
                                  image: NetworkImage(car.image),
                                  height: 272,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            AppBar(
                              actions: [
                                IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                        'assets/svg/favorite.svg')),
                              ],
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32)),
                          ),
                          padding:
                              EdgeInsets.only(top: 12, left: 12, right: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 6,
                                  width: 88,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    car.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/xcar-full-black.png'),
                                    image: NetworkImage(car.brandImage),
                                    height: 36,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                car.brandName,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    direction: Axis.horizontal,
                                    rating: 3.5,
                                    itemCount: 5,
                                    itemSize: 24,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    '111 Rating | Preview',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 24,
                                thickness: 2,
                                color: Color.fromARGB(255, 245, 244, 244),
                              ),
                              const Text(
                                'Specifications',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 12),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: boxSpecification(context,
                                            '${car.seats}', 'Seats', ''),
                                      ),
                                      Expanded(
                                        child: boxSpecification(context,
                                            '${car.engine}', 'Engine', ''),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: boxSpecification(
                                            context,
                                            '${car.topSpeed}',
                                            'Top speed',
                                            'km/h'),
                                      ),
                                      Expanded(
                                        child: boxSpecification(
                                            context,
                                            '${car.horsePower}',
                                            'Horse Power',
                                            'hp'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Car Renter',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(999),
                                        child: FadeInImage(
                                          placeholder: const AssetImage(
                                              'assets/images/xcar-full-black.png'),
                                          image: NetworkImage(
                                              distributorModel.image),
                                          width: 42,
                                          height: 42,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        distributorModel.name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        child: const Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Icon(Icons.phone, size: 32),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      GestureDetector(
                                        child: const Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child:
                                                Icon(Icons.message, size: 32),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Divider(
                                height: 24,
                                thickness: 2,
                                color: Color.fromARGB(255, 245, 244, 244),
                              ),
                              const Text(
                                'Desciption',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 70,
                                child: Text(
                                  car.descriptions,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              const Divider(
                                height: 24,
                                thickness: 2,
                                color: Color.fromARGB(255, 245, 244, 244),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24)),
                                    ),
                                    enableDrag: true,
                                    builder: (context) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                200,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons
                                                      .arrow_back_ios_new_rounded),
                                                ),
                                                title: const Text(
                                                  'Car Details',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                titleAlignment:
                                                    ListTileTitleAlignment
                                                        .center,
                                              ),
                                              const Divider(
                                                height: 24,
                                                thickness: 2,
                                                color: Color.fromARGB(
                                                    255, 245, 244, 244),
                                              ),
                                              const SizedBox(height: 12),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Text(
                                                  car.descriptions,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'See All Details',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios_rounded),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 24,
                                thickness: 4,
                                color: Color.fromARGB(255, 245, 244, 244),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'No Rating Yet',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Rate Car',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                              ratingAndPreview(context),
                              const SizedBox(height: 12),
                              ReviewsCardWidget(),
                              ReviewsCardWidget(),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24)),
                                    ),
                                    enableDrag: true,
                                    builder: (context) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                200,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons
                                                      .arrow_back_ios_new_rounded),
                                                ),
                                                title: const Text(
                                                  'Car Details',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                titleAlignment:
                                                    ListTileTitleAlignment
                                                        .center,
                                              ),
                                              const Divider(
                                                height: 24,
                                                thickness: 2,
                                                color: Color.fromARGB(
                                                    255, 245, 244, 244),
                                              ),
                                              const SizedBox(height: 12),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Text(
                                                  car.descriptions,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'See All Reviews',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios_rounded),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 24,
                                thickness: 2,
                                color: Color.fromARGB(255, 245, 244, 244),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is CarDetailFailure) {
          return Center(child: Text(state.error));
        } else {
          return const Center(child: Text('No load car'));
        }
      },
    );
  }

  Widget boxSpecification(
      BuildContext context, String spec, String specType, String unit) {
    return Card(
      elevation: 1,
      color: Color(0xffe5e5e5),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              specType,
              style: const TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 95, 94, 94)),
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: spec,
                  ),
                  const TextSpan(
                    text: ' ',
                  ),
                  TextSpan(
                    text: unit,
                  )
                ],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ratingAndPreview(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Row(
        children: [
          Container(
            width: 144,
            height: 180,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 245, 244, 244),
                borderRadius: BorderRadius.circular(24)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 30.0,
                  lineWidth: 7.0,
                  percent: 0.8,
                  center: const Text("3.5"),
                  progressColor: Colors.green,
                ),
                const SizedBox(height: 4),
                RatingBarIndicator(
                  direction: Axis.horizontal,
                  rating: 3.5,
                  itemCount: 5,
                  itemSize: 24,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star_rate_rounded,
                    color: Colors.amber,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    '8 rating and previews',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: rating.map((e) {
                return RatingBarWidget(
                    rating: e,
                    totalRatings: e * 2 - 1,
                    progress: (e * 100) / (100 * 5));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

List<int> rating = [5, 4, 3, 2, 1];
