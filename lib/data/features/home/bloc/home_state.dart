import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';

import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  // final List<Slider> sliders;
  final List<Brand> brands;
  final List<Car> cars;

  HomeLoaded({
    // required this.sliders,
    required this.brands,
    required this.cars,
  });

  @override
  List<Object> get props => [ brands, cars];
}

class HomeError extends HomeState {
  final String error;

  const HomeError({required this.error});

  @override
  List<Object> get props => [error];
}