// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:carx/components/item_car.dart';
import 'package:carx/components/item_category.dart';
import 'package:carx/features/car/bloc/car_bloc.dart';
import 'package:carx/features/car/bloc/car_event.dart';
import 'package:carx/features/car/bloc/car_state.dart';
import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';

import 'package:carx/service/api/api_constants.dart';
import 'package:carx/service/api/reponsitory/car_reponsitory.dart';


import 'package:carx/features/search/ui/search_view.dart';
import 'package:carx/features/categories/ui/categories_view.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late TabController controller;
  late StreamController sliderController;

  TabNotifier tabNotifier = TabNotifier(currentItem: 0);

  final carBloc = CarBloc(CarReponsitory.response());
  @override
  void initState() {
    controller = TabController(length: nameBrands.length, vsync: this);
    sliderController = StreamController.broadcast();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    sliderController.close();
    carBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 4),
          child: Image.asset('assets/images/xcar-full-black.png'),
        ),
        title: const Text('CarX'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesView(),));
            },
            icon: SvgPicture.asset('assets/svg/bell.svg'),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/svg/favorite.svg'),
          )
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CarBloc>(
            create: (context) => carBloc..add(FetchCars()),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
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
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchView(),
                          ));
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
                          )
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
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return ItemCategory(brand: brands.elementAt(index));
                },
                itemCount: 8,
              ),
              const SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Deals',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
              SliverToBoxAdapter(
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
                          tabs: nameBrands.map((name) {
                            return Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: tabNotifier.currentItem ==
                                          nameBrands.indexOf(name)
                                      ? Colors.amber
                                      : Colors.transparent,
                                  border: Border.all(
                                      width: 1,
                                      color: tabNotifier.currentItem ==
                                              nameBrands.indexOf(name)
                                          ? Colors.transparent
                                          : Colors.black),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(999)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Text(name,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ),
                            );
                          }).toList(),
                          indicatorColor: Colors.transparent,
                        ),
                        BlocBuilder<CarBloc, CarState>(
                            builder: (context, state) {
                          if (state is CarLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is CarSuccess) {
                            List<Car> cars = state.cars.where((car) {
                              String currentBrand = nameBrands[tabNotifier.currentItem];
                              return car.brand.contains(currentBrand == 'All' ? '' : currentBrand);
                            }).toList();
                            int length = cars.length;
                            int sizeCar = length % 2 == 0 ? length : length + 1;
                            return SizedBox(
                              height: sizeCar / 2 * 280 + 16 * sizeCar / 2,
                              child: TabBarView(
                                controller: controller,
                                physics: const NeverScrollableScrollPhysics(),
                                children: nameBrands.map((e) {
                                  return GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: length,
                                    itemBuilder: (context, index) {
                                      return Align(
                                        alignment: Alignment.center,
                                        child:
                                            ItemCar(car: cars.elementAt(index)),
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
                                }).toList(),
                              ),
                            );
                          } else if (state is CarFailure) {
                            return Text('Error: ${state.error}');
                          } else {
                            return Text('Something went wrong.');
                          }
                        }),
                      ],
                    );
                  },
                ),
              ),
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

const List<Brand> brands = [
  Brand(name: 'BMW', image: '$host/images/brands/bmw.png'),
  Brand(name: 'Bugati', image: '$host/images/brands/bugati.png'),
  Brand(name: 'Ferrari', image: '$host/images/brands/ferrari.png'),
  Brand(name: 'Honda', image: '$host/images/brands/honda.png'),
  Brand(name: 'Lamborghini', image: '$host/images/brands/lamborghini.png'),
  Brand(name: 'Mercedes', image: '$host/images/brands/mercedes.png'),
  Brand(name: 'Tesla', image: '$host/images/brands/tesla.png'),
  Brand(name: 'Other', image: '$host/images/brands/other.png'),
];
const List<String> nameBrands = [
  'All',
  'BMW',
  'Bugati',
  'Ferrari',
  'Honda',
  'Lamborghini',
  'Mercedes',
  'Tesla',
  'Other'
];

class TabNotifier with ChangeNotifier {
  int currentItem;
  TabNotifier({required this.currentItem});

  void selectedTab(int itemTab) {
    currentItem = itemTab;
    notifyListeners();
  }
}
