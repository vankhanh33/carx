import 'package:carx/data/model/brand.dart';


abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<Brand> brands;

  CategoriesSuccess({required this.brands});
}

class CategoriesFailure extends CategoriesState {
  final String error;

  CategoriesFailure({required this.error});
}
