import 'package:cached_network_image/cached_network_image.dart';
import 'package:carx/data/model/brand.dart';
import 'package:carx/data/presentation/categories/bloc/categories_bloc.dart';
import 'package:carx/data/presentation/categories/bloc/categories_event.dart';
import 'package:carx/data/presentation/categories/bloc/categories_state.dart';

import 'package:carx/data/reponsitories/car/car_reponsitory_impl.dart';
import 'package:carx/utilities/app_colors.dart';
import 'package:carx/utilities/app_routes.dart';
import 'package:carx/utilities/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView>
    with TickerProviderStateMixin {
  late CategoriesBloc bloc;

  @override
  void initState() {
    bloc = CategoriesBloc(CarReponsitoryImpl.response());
    bloc.add(FetchBrandsEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.routeSearch);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is CategoriesSuccess) {
            List<Brand> brands = state.brands;

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.routeCarByBrand,
                                arguments: brands[index]);
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                padding: const EdgeInsets.all(12),
                                child: CachedNetworkImage(
                                  imageUrl: brands[index].image,
                                  fit: BoxFit.contain,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              Text(
                                brands[index].name,
                                style: AppText.subtitle1,
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: brands.length,
                    )
                  ],
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: SpinKitCircle(
                color: AppColors.primary,
                size: 70,
              ),
            ),
          );
        },
      ),
    );
  }
}
