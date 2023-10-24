// ignore_for_file: library_private_types_in_public_api

import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/car_detail.dart';
import 'package:carx/data/model/detail.dart';
import 'package:carx/data/model/distributor_model.dart';
import 'package:carx/features/car_detail/bloc/detail_bloc.dart';
import 'package:carx/features/car_detail/bloc/detail_event.dart';
import 'package:carx/features/car_detail/bloc/detail_state.dart';
import 'package:carx/service/api/reponsitory/car_reponsitory.dart';
import 'package:carx/service/api/request/user_request.dart';
import 'package:carx/features/order/provider/orderr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    Car car = ModalRoute.of(context)!.settings.arguments as Car;
    return Scaffold(
      body: BlocBuilder<CarDetailBloc, CarDetailState>(
        bloc: carDetailBloc..add(FetchCarDetailEvent(car: car)),
        builder: (context, state) {
          if (state is CarDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CarDetailSuccess) {
            final Detail detail = state.detail;
            final CarDetail car = detail.carDetail;
            final DistributorModel distributorModel = detail.distributorModel;
            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Color.fromARGB(255, 142, 142, 143),
                child: Stack(children: [
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
                            color: Color(0xffe5e5e5),
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
                                    color: Colors.grey[600],
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    car.brandName,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(Icons.star_half_sharp),
                                      SizedBox(height: 8),
                                      Text(
                                        '4.5 | Preview',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Specifications',
                                style: TextStyle(
                                    fontSize: 18,
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
                                    fontSize: 18,
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
                                            padding: EdgeInsets.all(4.0),
                                            child: Icon(Icons.phone, size: 28),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      GestureDetector(
                                        child: const Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child:
                                                Icon(Icons.message, size: 28),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Desciption',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                car.descriptions,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 54,
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OrderView(),
                              settings: RouteSettings(arguments: car)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                        ),
                        child: RichText(
                          text: TextSpan(
                              text: 'Book Now',
                              children: <TextSpan>[
                                const TextSpan(text: ' | '),
                                TextSpan(text: '\$${car.pricePerDay}'),
                              ],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          } else if (state is CarDetailFailure) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('No load car'));
          }
        },
      ),
    );
  }

  Widget boxSpecification(
      BuildContext context, String spec, String specType, String unit) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              specType,
              style: const TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 95, 94, 94)),
            ),
            SizedBox(height: 12),
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
}
