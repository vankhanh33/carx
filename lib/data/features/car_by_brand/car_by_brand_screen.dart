import 'package:carx/components/shimmer_load_car.dart';
import 'package:carx/data/features/car_by_brand/bloc/car_by_brand_event.dart';
import 'package:carx/data/features/car_by_brand/bloc/car_by_brand_state.dart';

import 'package:carx/data/model/brand.dart';
import 'package:carx/data/reponsitories/car_reponsitory.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carx/components/item_car.dart';
import 'package:carx/data/model/car.dart';

import 'bloc/car_by_brand_bloc.dart';

class CarByBrandScreen extends StatelessWidget {
  const CarByBrandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brand brand = ModalRoute.of(context)!.settings.arguments as Brand;
   
    return Scaffold(
      appBar: AppBar(
        title: Text(brand.name),
      ),
      body: BlocProvider(
        create: (context) => CarByBrandBloc(CarReponsitory.response())
          ..add(FetchCarsByBrand(brandId: brand.id!)),
        child: BlocBuilder<CarByBrandBloc, CarByBrandState>(
          builder: (context, state) {
            if (state is CarByBrandLoading) {
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: GridView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const ShimmerLoadCar();
                  },
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 280,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 1.0,
                    maxCrossAxisExtent: 300,
                  ),
                ),
              );
            } else if (state is CarByBrandSuccess) {
              List<Car> cars = state.cars;
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.center,
                      child: ItemCar(car: cars.elementAt(index)),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 280,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 1.0,
                    maxCrossAxisExtent: 300,
                  ),
                ),
              );
            } else if (state is CarByBrandFailure) {
              return Center(child: Text('Error fetch data ${state.error}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
