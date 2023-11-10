import 'package:carx/data/model/car_detail.dart';

import 'package:carx/data/model/distributor.dart';
import 'package:carx/data/features/car_detail/bloc/detail_event.dart';
import 'package:carx/data/features/car_detail/bloc/detail_state.dart';
import 'package:carx/data/reponsitories/car/car_reponsitory.dart';
import 'package:carx/service/local/favorite_car_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailBloc extends Bloc<CarDetailEvent, CarDetailState> {

  CarDetailBloc(
      CarReponsitory carRepository, CarFavoriteService carFavoriteService)
      : super(const CarDetailState.initial()) {
    on<FetchCarDetailEvent>(
      (event, emit) async {
        emit(state.copyWith(detailStatus: CarDetailStatus.loading));
        try {
          final Future<CarDetail> carDetailFuture =
              carRepository.fetchCarDetailsByCarId(event.car.id);
          final Future<Distributor> distributorFuture =
              carRepository.fetchDistributorByCarId(event.car.id);

          List<dynamic> results =
              await Future.wait([carDetailFuture, distributorFuture]);

          final CarDetail carDetail = results[0];
          final Distributor distributor = results[1];
          emit(state.copyWith(
            detailStatus: CarDetailStatus.success,
            carDetail: carDetail,
            distributor: distributor,
          ));
        } catch (e) {
          emit(state.copyWith(detailStatus: CarDetailStatus.failure));
        }
      },
    );
    on<CheckCarFavoriteEvent>(
      (event, emit) async {
        bool isFavorite =
            await carFavoriteService.isExistCarFavorite(carId: event.carId);
        emit(state.copyWith(isFavorite: isFavorite));
      },
    );
    on<AddOrDeleteCarFavoriteEvent>(
      (event, emit) async {
        bool isFavorite =
            await carFavoriteService.addOrDeleteCarFavorite(car: event.car);
        emit(state.copyWith(isFavorite: isFavorite));
      },
    );
  }
 
}
