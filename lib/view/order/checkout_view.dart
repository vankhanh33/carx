// ignore_for_file: sort_child_properties_last

import 'package:carx/view/car_detail_view.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Checkout'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat))],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(22),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(999),
              ),
            ),
            elevation: 2,
          ),
          child: const Text(
            'Continue to payments',
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
                          CircleAvatar(
                            child: Icon(Icons.location_on_outlined),
                          ),
                          SizedBox(width: 16),
                          SizedBox(
                            width: 212,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Home',
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
                      child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCaTFqj2g8TYUB5bP6RqoOmWRM4Aj3VdigRQ&usqp=CAU',
                          width: 72,
                          height: 72,
                          fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BMW M5 Series',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '@Khanh Super Car',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '\$120',
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
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {});
                  },
                  leadingIcon: Icon(Icons.car_crash_rounded),
                  requestFocusOnTap: false,
                  inputDecorationTheme: InputDecorationTheme(
                    border: InputBorder.none,
                  ),
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
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
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {});
                  },
                  leadingIcon: Icon(Icons.payment),
                  requestFocusOnTap: false,
                  inputDecorationTheme: InputDecorationTheme(
                    border: InputBorder.none,
                  ),
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
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
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'From time',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '30-10-2023',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'End time',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '01-11-2023',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '\$1200',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '\$10',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(
                      height: 1,
                      color: Color.fromARGB(255, 202, 201, 201),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '\$1210',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 58),
            ],
          ),
        ),
      ),
    );
  }
}
