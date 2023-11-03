import 'package:carx/data/model/car_detail.dart';

import 'package:carx/data/model/distributor.dart';
import 'package:carx/data/features/car_detail/bloc/detail_event.dart';
import 'package:carx/data/features/car_detail/bloc/detail_state.dart';
import 'package:carx/data/reponsitories/car_reponsitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailBloc extends Bloc<CarDetailEvent, CarDetailState> {
  CarDetailBloc(CarReponsitory carRepository) : super(CarDetailInitial()) {
    on<FetchCarDetailEvent>(
      (event, emit) async {
        emit(CarDetailLoading());
        try {
          final Future<CarDetail> carDetailFuture =
              carRepository.fetchCarDetailsByCarId(event.car.id);
          final Future<Distributor> distributorFuture =
              carRepository.fetchDistributorByCarId(event.car.id);

          List<dynamic> results =
              await Future.wait([carDetailFuture, distributorFuture]);

          final CarDetail carDetail = results[0];
          final Distributor distributor = results[1];
          emit(CarDetailSuccess(
              carDetail: carDetail, distributor: distributor));
        } catch (e) {
          emit(CarDetailFailure(error: e.toString()));
        }
      },
    );
  }
}
