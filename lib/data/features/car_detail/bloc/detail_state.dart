import 'package:carx/data/model/car_detail.dart';

import 'package:carx/data/model/distributor.dart';

abstract class CarDetailState {}

class CarDetailInitial extends CarDetailState {}

class CarDetailLoading extends CarDetailState {}

class CarDetailSuccess extends CarDetailState {
  final CarDetail carDetail;
  final Distributor distributor;
  CarDetailSuccess({required this.carDetail, required this.distributor});
}

class CarDetailFailure extends CarDetailState {
  final String error;

  CarDetailFailure({required this.error});
}
