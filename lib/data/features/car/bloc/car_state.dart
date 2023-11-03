import 'package:carx/data/model/car.dart';

abstract class CarState {}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarSuccess extends CarState {
  final List<Car> cars;

  CarSuccess({required this.cars});
}

class CarFailure extends CarState {
  final String error;

  CarFailure({required this.error});
}
