import 'package:carx/components/item_car.dart';
import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/features/categories/bloc/categories_bloc.dart';
import 'package:carx/features/categories/bloc/categories_event.dart';
import 'package:carx/features/categories/bloc/categories_state.dart';

import 'package:carx/service/api/reponsitory/reponsitory.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView>
    with TickerProviderStateMixin {
  late CategoriesBloc bloc;
  late TabController tabController;
  @override
  void initState() {
    bloc = CategoriesBloc(Reponsitory.response());
    bloc.add(FetchBrandsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CategoriesSuccess) {
          List<Brand> brands = state.brands;
          tabController = TabController(length: brands.length, vsync: this);
          return Scaffold(
            appBar: AppBar(
              leading: Container(
                margin: const EdgeInsets.only(left: 4),
                child: Image.asset('assets/images/xcar-full-black.png'),
              ),
              title: const Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            body: Row(
              children: <Widget>[
                SizedBox(
                  height: double.infinity,
                  child: ExtendedTabBar(
                    scrollDirection: Axis.vertical,
                    isScrollable: true,
                    labelColor: Colors.black,
                    tabs: brands.map((brand) {
                      return SizedBox(
                        height: 60,
                        child: ExtendedTab(
                          scrollDirection: Axis.vertical,
                          icon: Image.network(
                            brand.image,
                            width: 42,
                            height: 42,
                          ),
                        ),
                      );
                    }).toList(),
                    controller: tabController,
                  ),
                ),
                Expanded(
                  child: ExtendedTabBarView(
                    controller: tabController,
                    scrollDirection: Axis.vertical,
                    children: brands.map((brand) {
                      return GridView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 340,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          mainAxisExtent: 200,
                        ),
                        itemBuilder: (context, index) {
                          return Center(
                            child: ItemCar(
                              car: Car(
                                  id: 1,
                                  name: brand.name,
                                  image: brand.image,
                                  price: 123,
                                  brand: brand.name),
                            ),
                          );
                        },
                        itemCount: brands.length,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
