import 'package:carx/model/brand.dart';
import 'package:carx/model/car.dart';

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
}
