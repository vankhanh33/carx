import 'package:carx/data/model/slider.dart';
import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/data/features/home/bloc/home_event.dart';
import 'package:carx/data/features/home/bloc/home_state.dart';
import 'package:carx/data/reponsitories/car/car_reponsitory.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CarReponsitory repository;

  HomeBloc(this.repository) : super(HomeState.initial()) {
    on<FetchDataHomeEvent>(
      (event, emit) async {
        emit(state.copyWith(status: HomeStatus.loading));
        try {
          final futures = await Future.wait([
            repository.fetchBrands(),
            repository.fetchCars(),
            repository.fetchSliders()
          ]);

          final brands = futures[0] as List<Brand>;
          final cars = futures[1] as List<Car>;
          final sliders = futures[2] as List<SliderImage>;
          List<Car> carsbyBrand =
              cars.where((car) => car.brand == brands.first.name).toList();
          emit(state.copyWith(
            status: HomeStatus.success,
            brands: brands,
            cars: cars,
            carsByBrand: carsbyBrand,
            sliders: sliders,
          ));
        } catch (e) {
          emit(state.copyWith(status: HomeStatus.failure));
        }
      },
    );
    on<BrandSelectionTabHomeEvent>((event, emit) {
      List<Car> cars = state.cars;
      List<Car> carsbyBrand =
          cars.where((car) => car.brand == event.brandName).toList();
      emit(state.copyWith(
          carsByBrand: carsbyBrand, selectedTab: event.selectedTab));
    });
    on<UpdateIndexIndicatorSlider>(
      (event, emit) => emit(
        state.copyWith(currentIndexSlider: event.index),
      ),
    );
  }
}
