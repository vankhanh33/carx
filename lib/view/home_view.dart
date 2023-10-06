import 'package:carousel_slider/carousel_slider.dart';
import 'package:carx/bloc/auth/auth_bloc.dart';
import 'package:carx/bloc/auth/auth_event.dart';
import 'package:carx/components/item_car.dart';
import 'package:carx/components/item_category.dart';
import 'package:carx/service/auth/firebase_auth_provider.dart';
import 'package:carx/view/car_detail_view.dart';
import 'package:carx/view/categories_view.dart';
import 'package:carx/view/login/login_view.dart';
import 'package:carx/view/login/login_with_phone_view.dart';
import 'package:carx/view/order/checkout_view.dart';
import 'package:carx/view/order/confirm_payment_view.dart';
import 'package:carx/view/order/payment_method_view.dart';
import 'package:carx/view/personal_view.dart';
import 'package:carx/view/search_view.dart';
import 'package:carx/view/top_deals_view.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> list = [];
  int _currentItem = 0;
  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      list.add('Item $i');
    }
    super.initState();
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
            onPressed: () {},
            icon: SvgPicture.asset('assets/svg/bell.svg'),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/svg/favorite.svg'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: CustomScrollView(
          //  physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => CategoriesView(),
                        // ));
                        context.read<AuthBloc>().add(AuthEventLogOut());
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
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
                    Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            pauseAutoPlayOnTouch: true,
                            aspectRatio: 16 / 9,
                            height: 175,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentItem = index;
                              });
                            },
                          ),
                          items: urlImages.map((urlImage) {
                            return Builder(
                              builder: (context) {
                                return Image.network(
                                  urlImage,
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width,
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
                            position: _currentItem,
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
                return ItemCategory(name: 'Item car $index');
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
              child: Container(
                height: 50, // Đặt chiều cao cho ListView
                child: 
                 ListView.builder(
                  scrollDirection:
                      Axis.horizontal, // Cho phép cuộn theo chiều ngang
                  itemCount: 10, // Số lượng item
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius:
                                BorderRadius.all(Radius.circular(999))),
                        margin: const EdgeInsets.all(8),
                        child: Center(
                          child: Text('Item $index'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {},
                    child: ItemCar(),
                  ),
                );
              }, childCount: 10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 280,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
                maxCrossAxisExtent: 300,
              ),
            )
          ],
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
