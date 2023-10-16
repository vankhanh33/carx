import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';

abstract class ApiProvider {
  Future<void> createUser({
    required String id,
    required String name,
    required String email,
  });
  Future<void> createUserWithGoogle({
    required String id,
    String? name,
     String? email,
    String? image,
  });

  Future<List<Brand>> fetchBrands();
   Future<List<Car>> fetchCars();
   Future<List<Car>> fetchCarByBrand({required String brand});
}
