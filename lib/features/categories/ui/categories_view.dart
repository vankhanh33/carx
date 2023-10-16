import 'package:carx/data/model/brand.dart';
import 'package:carx/features/categories/bloc/categories_bloc.dart';
import 'package:carx/features/categories/bloc/categories_event.dart';
import 'package:carx/features/categories/bloc/categories_state.dart';

import 'package:carx/service/api/reponsitory/reponsitory.dart';
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
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 145,
                        mainAxisExtent: 140,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Image.network(
                                state.brands.elementAt(index).image,
                                fit: BoxFit.contain,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Text("Failed");
                                },
                              ),
                            ),
                            Text(
                              state.brands.elementAt(index).name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                      itemCount: state.brands.length,
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}




