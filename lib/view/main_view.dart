// ignore_for_file: deprecated_member_use

import 'package:carx/components/item_car.dart';
import 'package:carx/view/home_view.dart';
import 'package:carx/view/personal_view.dart';
import 'package:carx/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: const HomeView(),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: currentItem,
        onTap: (value) {
          setState(() {
            currentItem = value;
          });
        },
        showUnselectedLabels: false,
        backgroundColor: Colors.blue,
        fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
