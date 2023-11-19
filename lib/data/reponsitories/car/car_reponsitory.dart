import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/car_detail.dart';

import 'package:carx/data/model/distributor.dart';
import 'package:carx/data/model/slider.dart';
import 'package:carx/data/model/car_review.dart';

abstract class CarReponsitory {
  Future<List<Car>> fetchCars();

  Future<List<SliderImage>> fetchSliders();

  Future<List<Car>> fetchCarsByBrand(int brandId);

  Future<List<Brand>> fetchBrands();

  Future<CarDetail> fetchCarDetailsByCarId(int id);

  Future<Distributor> fetchDistributorByCarId(int id);

  Future<List<CarReview>> fetchReviewBycar(int carId);

  Future<void> addReview({
    required double rating,
    required String comment,
    required String userId,
    required int carId,
  });
}
