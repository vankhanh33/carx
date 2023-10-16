
import 'package:carx/data/model/car_detail.dart';
import 'package:carx/utilities/dialog/success_order_dialog.dart';
import 'package:carx/view/order/provider/checkout_notifier.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  CheckoutNotifier notifier = CheckoutNotifier();

  double shipAmount = 10;

  @override
  Widget build(BuildContext context) {
    final CarDetail carDetails =
        ModalRoute.of(context)!.settings.arguments as CarDetail;

    return ChangeNotifierProvider(
      create: (context) => notifier..updateAmount(carDetails.pricePerDay),
      child: Consumer<CheckoutNotifier>(
        builder: (context, notifier, child) => Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('Checkout'),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat))],
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.all(16),
            height: 52,
            child: ElevatedButton(
              onPressed: () {
               notifier.isCheck(context, carDetails);
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(999),
                  ),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Booking',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shipping Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        color: Color.fromARGB(137, 236, 236, 236),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.location_on_outlined, size: 32),
                              SizedBox(width: 16),
                              SizedBox(
                                width: 212,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'My Address',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '128 Nguyễn Đình Chiểu, thành phố Huế',
                                      style: TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.mode_edit_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  const Text(
                    'Order',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Color.fromARGB(137, 236, 236, 236),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.all(4),
                          child: FadeInImage(
                            placeholder: const AssetImage(
                                'assets/images/xcar-full-black.png'),
                            image: NetworkImage(carDetails.image),
                            height: 72,
                            width: 72,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              carDetails.name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              carDetails.brandName,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${carDetails.pricePerDay}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Choose Shipping',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Color.fromARGB(137, 236, 236, 236),
                    ),
                    child: DropdownMenu<String>(
                      width: (MediaQuery.of(context).size.width) - 20,
                      hintText: 'Choose shipping method',
                      onSelected: (value) {
                        if (value != null) notifier.updateShipping(value);
                      },
                      leadingIcon: const Icon(Icons.car_crash_rounded),
                      requestFocusOnTap: false,
                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none,
                      ),
                      dropdownMenuEntries: shipping
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Payment Methods',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Color.fromARGB(137, 236, 236, 236),
                    ),
                    child: DropdownMenu<String>(
                      width: (MediaQuery.of(context).size.width) - 20,
                      onSelected: (value) {
                        if (value != null) {
                          notifier.updatePayment(value);
                          print(notifier.shipping);
                        }
                      },
                      leadingIcon: const Icon(Icons.payment),
                      requestFocusOnTap: false,
                      hintText: 'Choose payments method',
                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none,
                      ),
                      dropdownMenuEntries: payments
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Rental Period',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Color.fromARGB(137, 236, 236, 236),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
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
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              icon: const Icon(Icons.access_time_sharp),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
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
                                      content: Text(
                                          'Please choose From Time first.'),
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
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                  const SizedBox(height: 12),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Color.fromARGB(137, 236, 236, 236),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Amount',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '\$ ${carDetails.pricePerDay * notifier.dayRent}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Shipping',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '\$$shipAmount',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(
                          height: 1,
                          color: Color.fromARGB(255, 202, 201, 201),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '\$${shipAmount + carDetails.pricePerDay * notifier.dayRent}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 84),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const List<String> shipping = [
  'Giao đến tận nhà',
  'Đến lấy tại nhà phân phối',
];

const List<String> payments = [
  'Nhận hàng và thanh toán',
];
