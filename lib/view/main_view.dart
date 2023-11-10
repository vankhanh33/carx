// ignore_for_file: deprecated_member_use

import 'package:carx/utilities/app_colors.dart';
import 'package:carx/utilities/navigation_controller.dart';
import 'package:carx/data/features/categories/ui/categories_view.dart';
import 'package:carx/data/features/home/ui/home_screen.dart';
import 'package:carx/data/features/order_management/ui/car_rental_booking.dart';
import 'package:carx/data/features/personal/personal_view.dart';
import 'package:carx/view/notification_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final MainController controller = Get.put(MainController());
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.currentItem.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            bottomNavigationItem(
              'assets/svg/home.svg',
              'Home',
              controller.currentItem.value,
              0,
            ),
            bottomNavigationItem(
              'assets/svg/categories.svg',
              'Categories',
              controller.currentItem.value,
              1,
            ),
            bottomNavigationItem(
              'assets/svg/explore.svg',
              'Explore',
              controller.currentItem.value,
              2,
            ),
            bottomNavigationItem(
              'assets/svg/bell.svg',
              'Notification',
              controller.currentItem.value,
              3,
            ),
            bottomNavigationItem(
              'assets/svg/person.svg',
              'Personal',
              controller.currentItem.value,
              4,
            ),
          ],
          currentIndex: controller.currentItem.value,
          onTap: (value) {
            controller.updateItem(value);
          },
          showUnselectedLabels: false,
          backgroundColor: AppColors.primary,
          fixedColor: AppColors.secondary,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  BottomNavigationBarItem bottomNavigationItem(
    String assetIcon,
    String label,
    int currentIndex,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        assetIcon,
        color: currentIndex == index ? AppColors.secondary : Colors.white,
      ),
      label: label,
    );
  }
}

final pages = [
  const HomeView(),
  const CategoriesView(),
  const CarRentalBooking(),
  const NotificationScreeen(),
  const PersonalView(),
];
