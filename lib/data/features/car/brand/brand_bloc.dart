import 'package:bloc/bloc.dart';

import 'package:carx/data/features/car/brand/brand_event.dart';
import 'package:carx/data/features/car/brand/brand_state.dart';
import 'package:carx/data/model/brand.dart';

import 'package:carx/data/reponsitories/car_reponsitory.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc(CarReponsitory reponsitory) : super(BrandInitial()) {
    on<FetchBrands>(
      (event, emit) async {
        emit(BrandLoading());
        try {
          final List<Brand> brands = await reponsitory.fetchBrands();
          emit(BrandSuccess(brands: brands));
        } catch (e) {
          emit(BrandFailure(error: e.toString()));
        }
      },
    );
  }
}
