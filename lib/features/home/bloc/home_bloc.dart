import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/features/home/bloc/home_event.dart';
import 'package:carx/features/home/bloc/home_state.dart';
import 'package:carx/service/api/reponsitory/Reponsitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Reponsitory repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<FetchDataHomeEvent>(
      (event, emit) async {
        emit(HomeLoading());
        try {
          final futures = await Future.wait([
            repository.fetchBrands(),
            repository.fetchCars(),
          ]);

          // final sliderData = futures[0];
          final brands = futures[0] as List<Brand>;
          final cars = futures[1] as List<Car>;

          emit(HomeLoaded(
            brands: brands,
            cars: cars,
          ));
        } catch (e) {
          emit(HomeError(error: e.toString()));
        }
      },
    );
  }
}
