import 'package:carx/constants/navigation_controller.dart';
import 'package:carx/features/categories/ui/categories_view.dart';
import 'package:carx/features/home/ui/home_test.dart';
import 'package:carx/view/personal_view.dart';

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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.currentItem.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/home.svg',
                  color: Colors.white,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/categories.svg',
                  color: Colors.white,
                ),
                label: 'Category'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/explore.svg',
                  color: Colors.white,
                ),
                label: 'Explore'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/bell.svg',
                  color: Colors.white,
                ),
                label: 'Notification'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/person.svg',
                  color: Colors.white,
                ),
                label: 'Personal'),
          ],
          currentIndex: controller.currentItem.value,
          onTap: (value) {
            controller.updateItem(value);
          },
          showUnselectedLabels: false,
          backgroundColor: Colors.yellow[700],
          fixedColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

final pages = [
  const HomeView(),
  const CategoriesView(),
  const Text('Hello'),
  const Text('Hello'),
  const PersonalView(),
];
