import 'package:carx/bloc/user/user_bloc.dart';
import 'package:carx/bloc/user/user_event.dart';
import 'package:carx/bloc/user/user_state.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/user.dart';
import 'package:carx/features/order/bloc/order_bloc.dart';
import 'package:carx/features/order/bloc/order_event.dart';
import 'package:carx/features/order/bloc/order_state.dart';
import 'package:carx/loading/loading_order/loading_screen_order.dart';

import 'package:carx/service/api/reponsitory/reponsitory.dart';

import 'package:carx/service/auth/firebase_auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    final Car car = ModalRoute.of(context)!.settings.arguments as Car;

    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderBloc()
            ..add(DeliveryUpdated(5))
            ..add(CarUpdated(car))
            ..add(PriceUpdated(car.price)),
        ),
        BlocProvider(
            create: (context) => UserBloc(
                  Reponsitory.response(),
                  FirebaseAuthProvider(),
                )..add(
                    FetchUser(),
                  )),
      ],
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state.isLoading) {
            LoadingOrderScreen().show(context: context);
          } else {
            LoadingOrderScreen().hide();
          }
        },
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: const Text('Order'),
              actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat))],
            ),
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
                        '\$${state.totalAmount}',
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
                      context
                          .read<OrderBloc>()
                          .add(OrderButtonClicked(context));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.amber[100],
                      fixedSize: const Size(130, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      side: const BorderSide(width: 1, color: Colors.amber),
                    ),
                    child: const Text(
                      'Continues',
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
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserLoading) {
                                  return const CircularProgressIndicator();
                                } else if (state is UserSuccess) {
                                  User user = state.user;
                                  context
                                      .read<OrderBloc>()
                                      .add(AddressUpdated(user.address));
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${user.name}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(height: 4),
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${user.address}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Mobile: ',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${user.phone}',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                              width: 1, color: Colors.blue),
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        child: const Text(
                                          'Home',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (state is UserFailure) {
                                  return Text(state.error);
                                } else
                                  return SizedBox();
                              },
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              height: 36,
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    side: const BorderSide(
                                        width: 1, color: Colors.black)),
                                child: const Text(
                                  'CHANGE ADDRESS',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(26, 189, 188, 188),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: Color(0xffe0e3e7),
                            ),
                            padding: EdgeInsets.all(4),
                            child: FadeInImage(
                              placeholder: const AssetImage(
                                  'assets/images/xcar-full-black.png'),
                              image: NetworkImage(car.image),
                              height: 105,
                              width: 105,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  car.name,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  car.brand,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '\$${car.price}/day',
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rental Period',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'From time',
                                style: TextStyle(fontSize: 14),
                              ),
                              TextButton.icon(
                                onPressed: () async {
                                  context
                                      .read<OrderBloc>()
                                      .add(FromTimeUpdated(context));
                                },
                                label: Text(
                                  state.fromTime == null
                                      ? 'Chọn ngày giờ'
                                      : DateFormat('dd/MM/yyyy HH:mm')
                                          .format(state.fromTime!),
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                icon: const Icon(Icons.access_time_sharp),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'End time',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  context
                                      .read<OrderBloc>()
                                      .add(EndTimeUpdated(context, car.price));
                                },
                                label: Text(
                                  state.endTime == null
                                      ? 'Chọn ngày giờ'
                                      : DateFormat('dd/MM/yyyy HH:mm')
                                          .format(state.endTime!),
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                icon: const Icon(Icons.access_time_sharp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 24,
                      thickness: 1,
                      color: Color(0xffe0e3e7),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price Details',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Price',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '\$${state.price}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Delivery Charges',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '\$${state.delivery}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 32,
                            thickness: 2,
                            color: Color(0xffe0e3e7),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\$${state.totalAmount != 0 ? state.totalAmount : car.price}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(32),
                      color: const Color(0xffe0e3e7),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/shield.svg',
                            color: Color(0xff57636C),
                            width: 45,
                            height: 45,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Safe and secure payments. Easy returns. 100% Authentic Products',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff57636C)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
