
import 'package:carx/data/model/brand.dart';

abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandSuccess extends BrandState {
  final List<Brand> brands;

  BrandSuccess({required this.brands});
}

class BrandFailure extends BrandState {
  final String error;

  BrandFailure({required this.error});
}
