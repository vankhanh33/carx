import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:carx/components/item_car.dart';
import 'package:carx/components/item_category.dart';
import 'package:carx/components/shimmer_load_brand.dart';
import 'package:carx/components/shimmer_load_car.dart';
import 'package:carx/data/reponsitories/car_reponsitory.dart';
import 'package:carx/utilities/app_colors.dart';
import 'package:carx/utilities/app_routes.dart';
import 'package:carx/utils/navigation_controller.dart';
import 'package:carx/data/features/car/bloc/car_bloc.dart';
import 'package:carx/data/features/car/bloc/car_event.dart';
import 'package:carx/data/features/car/bloc/car_state.dart';
import 'package:carx/data/features/car/brand/brand_bloc.dart';
import 'package:carx/data/features/car/brand/brand_event.dart';
import 'package:carx/data/features/car/brand/brand_state.dart';

import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  TabController? controller;
  late StreamController sliderController;

  TabNotifier tabNotifier = TabNotifier(currentItem: 0);
  List<String> nameBrands = [];
  late MainController mainController;

  @override
  void initState() {
    sliderController = StreamController.broadcast();
    mainController = Get.find();
    super.initState();
  }

  @override
  void dispose() {
    if (controller != null) {
      controller?.dispose();
    }
    sliderController.close();

    tabNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CarBloc>(
          create: (context) =>
              CarBloc(CarReponsitory.response())..add(FetchCars()),
        ),
        BlocProvider<BrandBloc>(
          create: (context) =>
              BrandBloc(CarReponsitory.response())..add(FetchBrands()),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Container(
            margin: const EdgeInsets.only(left: 4),
            child: Image.asset(
              'assets/images/xcar-195x195-black.png',
              fit: BoxFit.cover,
            ),
          ),
          leadingWidth: 99,
          actions: [
            IconButton(
              onPressed: () async {},
              icon: SvgPicture.asset(
                'assets/svg/bell.svg',
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/svg/favorite.svg',
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.routeSearch);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Color.fromARGB(255, 236, 235, 235)),
                          child: const TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                                hintText: 'Search...',
                                enabled: false,
                                prefixIcon: Icon(Icons.search,
                                    size: 24, color: Colors.black54),
                                suffixIcon: Icon(Icons.filter_list,
                                    size: 24, color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Special Offers',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'See all',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      StreamBuilder(
                        builder: (context, snapshot) {
                          return Stack(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  pauseAutoPlayOnTouch: true,
                                  aspectRatio: 16 / 9,
                                  height: 175,
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    sliderController.sink.add(index);
                                  },
                                ),
                                items: urlImages.map((urlImage) {
                                  return Builder(
                                    builder: (context) {
                                      return Image.network(
                                        urlImage,
                                        fit: BoxFit.fill,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: DotsIndicator(
                                  dotsCount: urlImages.length,
                                  position: snapshot.data,
                                  decorator: DotsDecorator(
                                    activeColor: Colors.white,
                                    color: Colors.grey,
                                    size: const Size.square(6.0),
                                    activeSize: const Size(12.0, 6.0),
                                    activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                        stream: sliderController.stream,
                        initialData: 0,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              BlocBuilder<BrandBloc, BrandState>(builder: (context, state) {
                if (state is BrandLoading) {
                  return SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 6.0,
                      crossAxisSpacing: 6.0,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      return const ShimmerItemCategory(
                        size: 54,
                      );
                    },
                    itemCount: 8,
                  );
                } else if (state is BrandSuccess) {
                  List<Brand> brands = state.brands.sublist(0, 7);
                  brands.add(
                    const Brand(
                        name: 'All',
                        image:
                            'https://cdn-icons-png.flaticon.com/128/9542/9542576.png'),
                  );
                  return SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 6.0,
                      crossAxisSpacing: 6.0,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      return ItemCategory(brand: brands.elementAt(index));
                    },
                    itemCount: brands.length,
                  );
                }
                return SliverToBoxAdapter(child: Container());
              }),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Deals',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => mainController.updateItem(1),
                          child: const Text(
                            'See all',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              BlocBuilder<BrandBloc, BrandState>(builder: (context, state) {
                if (state is BrandLoading) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 100,
                            height: 30,
                            child: Center(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.5),
                                highlightColor: Colors.grey,
                                child: Container(
                                  width: 70,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(999)),
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  );
                } else if (state is BrandSuccess) {
                  nameBrands = state.brands.map((e) => e.name).toList();
                  controller =
                      TabController(length: nameBrands.length, vsync: this);
                  return SliverToBoxAdapter(
                    child: ListenableBuilder(
                      listenable: tabNotifier,
                      builder: (context, child) {
                        return Column(
                          children: [
                            TabBar(
                              controller: controller,
                              isScrollable: true,
                              onTap: (value) {
                                tabNotifier.selectedTab(value);
                              },
                              overlayColor: MaterialStateProperty.all(
                                Colors.transparent,
                              ),
                              tabs: nameBrands.map((name) {
                                return Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: tabNotifier.currentItem ==
                                              nameBrands.indexOf(name)
                                          ? AppColors.primary
                                          : Colors.transparent,
                                      border: Border.all(
                                          width: 1,
                                          color: tabNotifier.currentItem ==
                                                  nameBrands.indexOf(name)
                                              ? Colors.transparent
                                              : Color(0xffe5e5e5)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(999)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Text(name,
                                        style: TextStyle(
                                            color: tabNotifier.currentItem ==
                                                    nameBrands.indexOf(name)
                                                ? AppColors.secondary
                                                : AppColors.fontColor,
                                            fontSize: 16)),
                                  ),
                                );
                              }).toList(),
                              indicatorColor: Colors.transparent,
                            ),
                            BlocBuilder<CarBloc, CarState>(
                              builder: (context, state) {
                                if (state is CarLoading) {
                                  return Container(
                                    height: 500,
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        mainAxisExtent: 280,
                                        mainAxisSpacing: 16.0,
                                        crossAxisSpacing: 16.0,
                                        childAspectRatio: 1.0,
                                        maxCrossAxisExtent: 300,
                                      ),
                                      itemBuilder: (context, index) {
                                        return ShimmerLoadCar();
                                      },
                                      itemCount: 4,
                                    ),
                                  );
                                } else if (state is CarSuccess) {
                                  List<Car> cars = state.cars
                                      .where((element) =>
                                          element.brand ==
                                          nameBrands[controller!.index])
                                      .toList();
                                  int eodHeight = cars.length % 2 == 0
                                      ? cars.length
                                      : cars.length + 1;
                                  int heightItem = 280;
                                  double height = eodHeight / 2 * heightItem +
                                      16 * eodHeight / 2;
                                  return Container(
                                    constraints:
                                        BoxConstraints.expand(height: height),
                                    child: TabBarView(
                                      controller: controller,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: nameBrands.map(
                                        (e) {
                                          return GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: cars.length,
                                            itemBuilder: (context, index) {
                                              return Align(
                                                alignment: Alignment.center,
                                                child: ItemCar(
                                                    car: cars.elementAt(index)),
                                              );
                                            },
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                              mainAxisExtent: 280,
                                              mainAxisSpacing: 16.0,
                                              crossAxisSpacing: 16.0,
                                              childAspectRatio: 1.0,
                                              maxCrossAxisExtent: 300,
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            )
                          ],
                        );
                      },
                    ),
                  );
                }
                return SliverToBoxAdapter(child: Container());
              }),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> urlImages = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZyVem3ZVH5DLvkQlsVraCMtG_lNJOgNvg-Q&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM2t1IpZpXNj5uHst69iihsjv4vzcywNLkuQ&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT07W_8R_54kGnRelgD7Eakaygq2MNpomegCg&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRFYwZ66mjVQfXTjaa_SQ1MSdIWXIG6UZexA&usqp=CAU'
];

class TabNotifier with ChangeNotifier {
  int currentItem;
  TabNotifier({required this.currentItem});

  void selectedTab(int itemTab) {
    currentItem = itemTab;
    notifyListeners();
  }
}
