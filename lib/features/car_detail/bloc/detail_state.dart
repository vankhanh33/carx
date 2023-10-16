import 'package:carx/data/model/detail.dart';

abstract class CarDetailState {}

class CarDetailInitial extends CarDetailState {}

class CarDetailLoading extends CarDetailState {}

class CarDetailSuccess extends CarDetailState {
  final Detail detail;

  CarDetailSuccess({required this.detail});
}

class CarDetailFailure extends CarDetailState {
  final String error;

  CarDetailFailure({required this.error});
}
