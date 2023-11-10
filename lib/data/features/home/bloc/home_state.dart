import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';

import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final List<Brand> brands;
  final List<Car> cars;
  final List<Car> carsByBrand;
  final HomeStatus status;
  final int selectedTab;
  const HomeState({
    required this.brands,
    required this.cars,
    required this.carsByBrand,
    required this.status,
    required this.selectedTab,
  });
  HomeState.initial()
      : cars = [],
        brands = [],
        carsByBrand = [],
        status = HomeStatus.initial,
        selectedTab = 0;

  HomeState copyWith({
    List<Brand>? brands,
    List<Car>? cars,
    List<Car>? carsByBrand,
    HomeStatus? status,
    int? selectedTab,
  }) =>
      HomeState(
        brands: brands ?? this.brands,
        cars: cars ?? this.cars,
        carsByBrand: carsByBrand ?? this.carsByBrand,
        status: status ?? this.status,
        selectedTab: selectedTab ?? this.selectedTab,
      );

  @override
  List<Object> get props => [brands, cars, carsByBrand, status, selectedTab];
}
