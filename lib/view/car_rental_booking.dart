import 'package:carx/view/item_car_booking.dart';
import 'package:flutter/material.dart';

class CarRentalBooking extends StatefulWidget {
  const CarRentalBooking({super.key});

  @override
  State<CarRentalBooking> createState() => _CarRentalBookingState();
}

class _CarRentalBookingState extends State<CarRentalBooking>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/xcar-full-black.png'),
        title: const Text('My Car Booking'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 42,
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.grey,
                tabs: tabs
                    .map(
                      (tab) => Tab(
                        child: Text(
                          tab,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return const CarItemBooking();
                    },
                    itemCount: 2,
                    shrinkWrap: true,
                  ),
                  const Text("It's completed here"),
                  const Text("It's Cancelled here"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CarRentalBooking(),
  ));
}

final tabs = ['Active', 'Completed', 'Cancelled'];
