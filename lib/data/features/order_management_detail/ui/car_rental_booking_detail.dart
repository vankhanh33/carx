// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';

import 'package:carx/data/features/order_management_detail/bloc/order_management_detail_bloc.dart';
import 'package:carx/data/features/order_management_detail/bloc/order_management_detail_event.dart';
import 'package:carx/data/features/order_management_detail/bloc/order_management_detail_state.dart';
import 'package:carx/data/model/brand.dart';

import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/delivery_address.dart';
import 'package:carx/data/model/order.dart';
import 'package:carx/data/model/order_management.dart';

import 'package:carx/data/reponsitories/order/order_reponsitory_impl.dart';
import 'package:carx/loading/loading.dart';

import 'package:carx/loading/loading_screen.dart';

import 'package:carx/utilities/app_colors.dart';

import 'package:carx/utilities/dialog/cancel_order_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarRentalBookingDetail extends StatefulWidget {
  const CarRentalBookingDetail({super.key});

  @override
  State<CarRentalBookingDetail> createState() => _CarRentalBookingDetailState();
}

class _CarRentalBookingDetailState extends State<CarRentalBookingDetail> {
  late OrderManagement orderManagement;
  late Car car;
  late Brand brand;
  late Order order;
  late DeliveryAddress deliveryAddress;
  late CountdownTimerController countdownController;
  late int endTime;

  @override
  void dispose() {
    countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orderManagement =
        ModalRoute.of(context)?.settings.arguments as OrderManagement;
    car = orderManagement.car;
    brand = orderManagement.brand;
    order = orderManagement.order;
    deliveryAddress = orderManagement.deliveryAddress;
    endTime = DateTime.parse(order.endTime!).millisecondsSinceEpoch;
    countdownController = CountdownTimerController(endTime: endTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return false;
        },
        child: BlocProvider(
          create: (context) => OrderManagementDetailBloc(
            OrderReponsitoryImpl.response(),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: brand.image,
                                  width: 24,
                                  height: 24,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    brand.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_filled_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 6),
                                    child: CountdownTimer(
                                      controller: countdownController,
                                      endTime: endTime,
                                      widgetBuilder: (_, time) {
                                        if (time == null ||
                                            order.status == 'Cancelled' ||
                                            order.status == 'Completed') {
                                          return const Text(
                                            'Finished',
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          );
                                        } else {
                                          return Text(
                                            '${time.days ?? 0}d ${time.hours ?? 0}h ${time.min ?? 0}m ${time.sec}s ',
                                            style: const TextStyle(
                                                color: Colors.redAccent),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(4),
                        child: CachedNetworkImage(
                          imageUrl: car.image,
                          height: 64,
                          width: 64,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: const Color(0xffe0e3e7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(text: 'ID Order - '),
                            TextSpan(text: '#${order.code}'),
                          ],
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary),
                        ),
                      ),
                      const Icon(
                        Icons.share_outlined,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: tracks.map((e) => itemTrack(context, e)).toList(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: const Color(0xffe0e3e7),
                  child: const Text(
                    'Shipping Details',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        deliveryAddress.recipientName ?? 'Default',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        deliveryAddress.address ?? 'Default',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
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
                            deliveryAddress.phone ?? 'Default',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: AppColors.lightGray,
                  child: const Text(
                    'Rental Period',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Start time',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${order.startTime}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'End time',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${order.endTime}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  color: Color(0xffe0e3e7),
                  child: const Text(
                    'Payment Details',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xffe0e3e7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            'assets/svg/payment.svg',
                            width: 48,
                            height: 48,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          '${order.paymentMethods}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '\$ ${order.amount}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Delivery Charges',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '\$${order.deliveryCharges ?? 'FREE'}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Discount',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '${order.discountAmount ?? 0}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 2,
                  thickness: 2,
                  color: Color(0xffe0e3e7),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$${order.totalAmount}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: order.status != 'Cancelled' &&
                            order.status != 'Completed',
                        child: Expanded(
                          child: BlocConsumer<OrderManagementDetailBloc,
                              OrderManagementDetailState>(
                            listener: (context, state) {
                              if (state is OrderLoadingCancelState) {
                                Loading()
                                    .show(context: context);
                              } else if (state is OrderCancelledSuccessState) {
                                Loading().hide();
                                Navigator.pop(context, true);
                              } else if (state is OrderCancelledFailureState) {
                                Loading().hide();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Cannot cancel due to error')));
                              }
                            },
                            builder: (context, state) {
                              return SizedBox(
                                height: 45,
                                child: InkWell(
                                  onTap: () async {
                                    final isCancelled =
                                        await showCancelOrderDialog(
                                      context: context,
                                      title: 'Cancelled Order',
                                      content:
                                          'Do you want to cancel your car rental booking?',
                                    );
                                    if (isCancelled) {
                                      context
                                          .read<OrderManagementDetailBloc>()
                                          .add(OrderCancellationEvent(
                                              order: order));
                                    }
                                  },
                                  overlayColor: const MaterialStatePropertyAll(
                                      Colors.transparent),
                                  child: const Center(
                                      child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.red),
                                  )),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: order.status != 'Cancelled' &&
                            order.status != 'Completed',
                        child: const SizedBox(
                          height: 22,
                          child: VerticalDivider(
                            width: 20,
                            thickness: 1,
                            color: Color(0xffe0e3e7),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: InkWell(
                            onTap: () {},
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            child: const Center(
                                child: Text('Support',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ))),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemTrack(BuildContext context, TrackOrder track) {
    final processes = track.processes;
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFF00AA07),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 77,
              decoration: BoxDecoration(
                color: Color(0xFF00AA07),
              ),
            ),
            Visibility(
              visible: track == tracks[tracks.length - 1],
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF00AA07),
                  shape: BoxShape.circle,
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: const TextStyle(fontSize: 14),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                    child: Text(
                      track.processes![index],
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF585858),
                      ),
                    ),
                  ),
                  itemCount: processes?.length,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

final tracks = [
  TrackOrder(title: 'Rented', processes: [
    'Booking confirmed',
    'Distributor is handling vehicle reservations'
  ]),
  TrackOrder(title: 'Inprogress', processes: [
    'Accept car reservations',
    'Prepare to deliver the car to you'
  ]),
  TrackOrder(title: 'Shipped', processes: [
    'Vehicle is delivered',
  ]),
  TrackOrder(title: 'Completed', processes: [
    'Rental Successfully Completed',
    'The vehicle has been returned to the distributor'
  ]),
];

class TrackOrder {
  String title;
  List<String>? processes;
  TrackOrder({required this.title, this.processes});
}
