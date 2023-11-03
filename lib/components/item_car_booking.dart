import 'package:cached_network_image/cached_network_image.dart';
import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/order.dart';
import 'package:carx/data/model/order_management.dart';
import 'package:carx/data/features/order_management_detail/ui/car_rental_booking_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CarItemBooking extends StatefulWidget {
  final OrderManagement orderManagement;

  const CarItemBooking({super.key, required this.orderManagement});

  @override
  State<CarItemBooking> createState() => _CarItemBookingState();
}

class _CarItemBookingState extends State<CarItemBooking> {
  late final Car car;
  late final Brand brand;
  late final Order order;
  late CountdownTimerController countdownController;
  late int endTime;
  @override
  void initState() {
    car = widget.orderManagement.car;
    brand = widget.orderManagement.brand;
    order = widget.orderManagement.order;

    endTime = DateTime.parse(order.endTime!).millisecondsSinceEpoch;
    countdownController = CountdownTimerController(endTime: endTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: const BoxDecoration(
        color: Color.fromARGB(26, 189, 188, 188),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Color(0xffe0e3e7),
                ),
                padding: EdgeInsets.all(4),
                child: CachedNetworkImage(
                  imageUrl: car.image,
                  width: 54,
                  height: 54,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          itemDetail(context, 'ID Order', '#${order.code}'),
          const SizedBox(height: 16),
          itemDetail(context, 'Total Amount', '\$${order.totalAmount}'),
          const SizedBox(height: 16),
          itemDetail(context, 'Status', '${order.status}'),
          const SizedBox(height: 16),
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
                          style: TextStyle(color: Colors.redAccent),
                        );
                      } else {
                        return Text(
                          '${time.days ?? 0}d ${time.hours ?? 0}h ${time.min ?? 0}m ${time.sec}s',
                          style: const TextStyle(color: Colors.redAccent),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget itemDetail(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
