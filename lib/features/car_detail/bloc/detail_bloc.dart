

import 'package:carx/data/model/detail.dart';
import 'package:carx/features/car_detail/bloc/detail_event.dart';
import 'package:carx/features/car_detail/bloc/detail_state.dart';
import 'package:carx/service/api/reponsitory/car_reponsitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailBloc extends Bloc<CarDetailEvent, CarDetailState> {
  CarDetailBloc(CarReponsitory carRepository) : super(CarDetailInitial()) {
    on<FetchCarDetailEvent>(
      (event, emit) async {
        emit(CarDetailLoading());
        try {
          final Detail detail =
              (await carRepository.fetchCarDetails(event.carId)) ;
          emit(CarDetailSuccess(detail: detail));
         
        } catch (e) {
          emit(CarDetailFailure(error: e.toString()));
        }
      },
    );
  }
}