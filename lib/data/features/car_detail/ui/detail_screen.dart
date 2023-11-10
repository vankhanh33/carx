// ignore_for_file: library_private_types_in_public_api, unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carx/components/rating_bar_widget.dart';
import 'package:carx/components/reviews_car.dart';
import 'package:carx/components/shimmer_load_brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/car_detail.dart';

import 'package:carx/data/model/distributor.dart';
import 'package:carx/data/features/car_detail/bloc/detail_bloc.dart';
import 'package:carx/data/features/car_detail/bloc/detail_event.dart';
import 'package:carx/data/features/car_detail/bloc/detail_state.dart';

import 'package:carx/data/reponsitories/car/car_reponsitory_impl.dart';
import 'package:carx/service/local/favorite_car_service.dart';
import 'package:carx/utilities/app_colors.dart';

import 'package:carx/utilities/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class CarDetailView extends StatefulWidget {
  const CarDetailView({Key? key}) : super(key: key);

  @override
  _CarDetailViewState createState() => _CarDetailViewState();
}

class _CarDetailViewState extends State<CarDetailView> {
  late CarDetailBloc carDetailBloc;

  @override
  void initState() {
    carDetailBloc =
        CarDetailBloc(CarReponsitoryImpl.response(), CarFavoriteService());

    super.initState();
  }

  @override
  void dispose() {
    carDetailBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Car car = ModalRoute.of(context)!.settings.arguments as Car;

    return BlocBuilder<CarDetailBloc, CarDetailState>(
      bloc: carDetailBloc
        ..add(FetchCarDetailEvent(car: car))
        ..add(CheckCarFavoriteEvent(car.id)),
      builder: (context, state) {
        if (state.detailStatus == CarDetailStatus.loading) {
          return const Scaffold(
            body: Center(
              child: SpinKitCircle(
                color: Colors.grey,
                size: 70,
              ),
            ),
          );
        } else if (state.detailStatus == CarDetailStatus.success) {
          final CarDetail carDetail = state.carDetail!;
          final Distributor distributor = state.distributor!;

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
                        '\$${carDetail.pricePerDay}/day',
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
                      Navigator.of(context)
                          .pushNamed(Routes.routeOrder, arguments: car);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      fixedSize: const Size(130, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      side: const BorderSide(width: 1, color: AppColors.lightGray),
                    ),
                    child: const Text(
                      'Book now',
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              color: AppColors.lightGray,
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
                                child: CachedNetworkImage(
                                  imageUrl: car.image,
                                  height: 272,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            AppBar(
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    carDetailBloc
                                        .add(AddOrDeleteCarFavoriteEvent(car));
                                  },
                                  icon: state.isFavorite
                                      ? const Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.redAccent,
                                          size: 26,
                                        )
                                      : const Icon(
                                          Icons.favorite_border_rounded,
                                          color: AppColors.primary,
                                          size: 26,
                                        ),
                                ),
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
                          padding: const EdgeInsets.only(
                              top: 12, left: 12, right: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 6,
                                  width: 44,
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
                                  Expanded(
                                    child: Text(
                                      car.name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  SizedBox(
                                    width: 70,
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          const ShimmerItemCategory(size: 30),
                                      imageUrl: carDetail.brandImage,
                                      height: 36,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                carDetail.brandName,
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
                                            '${carDetail.seats}', 'Seats', ''),
                                      ),
                                      Expanded(
                                        child: boxSpecification(
                                            context,
                                            '${carDetail.engine}',
                                            'Engine',
                                            ''),
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
                                            '${carDetail.topSpeed}',
                                            'Top speed',
                                            'km/h'),
                                      ),
                                      Expanded(
                                        child: boxSpecification(
                                            context,
                                            '${carDetail.horsePower}',
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
                                            'assets/images/logo-dark.png',
                                          ),
                                          image: NetworkImage(
                                              distributor.user.image!),
                                          width: 42,
                                          height: 42,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        distributor.user.name!,
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
                                  carDetail.descriptions,
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
                                                  carDetail.descriptions,
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
                                                  carDetail.descriptions,
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
        } else if (state.detailStatus == CarDetailStatus.failure) {
          return const Center(child: Text('Error fetch data'));
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
