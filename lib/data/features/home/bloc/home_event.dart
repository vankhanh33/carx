import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FethCarAndBrandHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class BrandSelectionTabHomeEvent extends HomeEvent {
  final int selectedTab;
  final String brandName;
  const BrandSelectionTabHomeEvent(
      {required this.selectedTab, required this.brandName});

  @override
  List<Object?> get props => [selectedTab, brandName];
}
