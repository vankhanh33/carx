import 'package:carx/data/model/car.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<Car> cars;

  SearchSuccessState(this.cars);
}

class SearchErrorState extends SearchState {
  final String errorMessage;

  SearchErrorState(this.errorMessage);
}