import 'package:carx/data/model/slider.dart';
import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';

import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final List<Brand> brands;
  final List<Car> cars;
  final List<Car> carsByBrand;
  final List<SliderImage> sliders;
  final int currentIndexSlider;
  final HomeStatus status;
  final int selectedTab;
  const HomeState({
    required this.brands,
    required this.cars,
    required this.carsByBrand,
    required this.sliders,
    required this.currentIndexSlider,
    required this.status,
    required this.selectedTab,
  });
  HomeState.initial()
      : cars = [],
        brands = [],
        sliders = [],
        carsByBrand = [],
        currentIndexSlider = 0,
        status = HomeStatus.initial,
        selectedTab = 0;

  HomeState copyWith({
    List<Brand>? brands,
    List<Car>? cars,
    List<Car>? carsByBrand,
    List<SliderImage>? sliders,
    int? currentIndexSlider,
    HomeStatus? status,
    int? selectedTab,
  }) =>
      HomeState(
        brands: brands ?? this.brands,
        cars: cars ?? this.cars,
        carsByBrand: carsByBrand ?? this.carsByBrand,
        sliders: sliders ?? this.sliders,
        currentIndexSlider: currentIndexSlider ?? this.currentIndexSlider,
        status: status ?? this.status,
        selectedTab: selectedTab ?? this.selectedTab,
      );

  @override
  List<Object> get props =>
      [brands, cars, carsByBrand, sliders,currentIndexSlider, status, selectedTab];
}
