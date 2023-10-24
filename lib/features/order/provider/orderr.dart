import 'package:carx/bloc/user/user_bloc.dart';
import 'package:carx/data/model/car_detail.dart';

import 'package:carx/features/order/provider/checkout_notifier.dart';
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
  OrderNotifier notifier = OrderNotifier();

  double shipAmount = 0;

  @override
  Widget build(BuildContext context) {
    final CarDetail carDetails =
        ModalRoute.of(context)!.settings.arguments as CarDetail;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => notifier..updateAmount(carDetails.pricePerDay),
        ),
        BlocProvider(
          create: (context) => UserBloc(Reponsitory.response(),FirebaseAuthProvider()),
        ),
      ],
      child: Consumer<OrderNotifier>(
        builder: (context, notifier, child) => Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('Checkout'),
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
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'day',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
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
                    notifier.isCheck(context, carDetails);
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
          body: SingleChildScrollView(
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Expanded(
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dat Viettel',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 4),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          '128 Nguyễn Đình Chiểu, thành phố Huế',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            'Mobile: ',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            '+84357699452',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
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
                                border:
                                    Border.all(width: 1, color: Colors.blue),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: const Text(
                                'Home',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.blue),
                              ),
                            ),
                          ],
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
                          image: NetworkImage(carDetails.image),
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
                              carDetails.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              carDetails.brandName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${carDetails.pricePerDay}/day',
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
                              await notifier.showFromDateTimePicker(context);
                            },
                            label: Text(
                              notifier.fromTime == null
                                  ? 'Chọn ngày giờ'
                                  : DateFormat('dd/MM/yyyy HH:mm')
                                      .format(notifier.fromTime!),
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
                            onPressed: () async {
                              if (notifier.fromTime != null) {
                                await notifier.showEndDateTimePicker(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please choose From Time first.'),
                                  ),
                                );
                              }
                            },
                            label: Text(
                              notifier.endTime == null
                                  ? 'Chọn ngày giờ'
                                  : DateFormat('dd/MM/yyyy HH:mm')
                                      .format(notifier.endTime!),
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
                            '\$ ${carDetails.pricePerDay * notifier.dayRent}',
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
                            '\$$shipAmount',
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
                            '\$${shipAmount + carDetails.pricePerDay * notifier.dayRent}',
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
      ),
    );
  }
}
