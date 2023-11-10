// ignore_for_file: use_build_context_synchronously

import 'package:carx/data/features/order_management/bloc/order_management_bloc.dart';
import 'package:carx/data/features/order_management/bloc/order_management_event.dart';
import 'package:carx/data/features/order_management/bloc/order_management_state.dart';

import 'package:carx/data/reponsitories/order/order_reponsitory_impl.dart';
import 'package:carx/service/auth/firebase_auth_provider.dart';
import 'package:carx/components/item_car_booking.dart';
import 'package:carx/components/shimmer_car_booking.dart';
import 'package:carx/utilities/app_colors.dart';
import 'package:carx/utilities/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarRentalBooking extends StatefulWidget {
  const CarRentalBooking({super.key});

  @override
  State<CarRentalBooking> createState() => _CarRentalBookingState();
}

class _CarRentalBookingState extends State<CarRentalBooking>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late OrderManagementBloc bloc;
  final tabs = ['Active', 'Completed', 'Cancelled'];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabs.length);
    bloc = OrderManagementBloc(
        OrderReponsitoryImpl.response(), FirebaseAuthProvider());
    bloc.add(FetchOrderManagementEvent());
    bloc.add(FetchOrderManagementByStatusEvent(status: tabs[0]));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Car Booking'),
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 48,
                child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.grey,
                  indicatorColor: AppColors.secondary,
                  tabs: tabs
                      .map(
                        (tab) => Tab(
                          child: Text(
                            tab,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onTap: (value) {
                    bloc.add(
                        FetchOrderManagementByStatusEvent(status: tabs[value]));
                  },
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: tabs
                      .map((tab) => BlocBuilder<OrderManagementBloc,
                              OrderManagementState>(
                            builder: (context, state) {
                              if (state.status ==
                                  OrderManagementStatus.loading) {
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    return const ShimmerCarItemBooking();
                                  },
                                  itemCount: 2,
                                );
                              } else if (state.status ==
                                  OrderManagementStatus.success) {
                                if (state.orderManagementsByStatus.isNotEmpty) {
                                  final orderManagements =
                                      state.orderManagementsByStatus;

                                  return ListView.builder(
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          final isCancel =
                                              await Navigator.pushNamed(context,
                                                  Routes.routeOrderDetail,
                                                  arguments:
                                                      orderManagements[index]);
                                          if (isCancel as bool) {
                                            Navigator.pushReplacementNamed(
                                                context, Routes.routeAllOrder);
                                          }
                                        },
                                        child: CarItemBooking(
                                          orderManagement:
                                              orderManagements[index],
                                        ),
                                      );
                                    },
                                    itemCount: orderManagements.length,
                                    shrinkWrap: true,
                                  );
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          'assets/images/order-empty.png',
                                          width: 166,
                                          height: 166,
                                        ),
                                      ),
                                      const Text(
                                        'You haven\'t rented any car yet',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  );
                                }
                              } else if (state.status ==
                                  OrderManagementStatus.failure) {
                                return const Center(child: Text("Failure"));
                              }
                              return Container();
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
