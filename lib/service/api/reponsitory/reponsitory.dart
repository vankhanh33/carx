import 'dart:convert';

import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/dio_response.dart';
import 'package:carx/service/api/api_constants.dart';
import 'package:carx/service/dio/dio_client.dart';
import 'package:dio/dio.dart';

class Reponsitory {
  final Dio _dio;
  const Reponsitory(this._dio);
  factory Reponsitory.response() => Reponsitory(DioClient.instance.dio);

  Future<List<Car>> fetchCars() async {
    try {
      final response = await _dio.get(getCar);
      if (response.statusCode == 200) {
        DioResponse dioResponse =
            DioResponse.fromJson(jsonDecode(response.data));

        if (dioResponse.status == 'OK') {
          final List<dynamic> responseData = dioResponse.data;
          final List<Car> cars =
              responseData.map((car) => Car.fromJson(car)).toList();

          return cars;
        } else {
          return [];
        }
      } else {
        throw Exception('Error request exception');
      }
    } catch (e) {
      throw Exception('Failed to fetch cars: $e');
    }
  }

  Future<List<Brand>> fetchBrands() async {
    try {
      final response = await _dio.get(getBrand);
      if (response.statusCode == 200) {
        DioResponse dioResponse =
            DioResponse.fromJson(jsonDecode(response.data));

        if (dioResponse.status == 'OK') {
          final List<dynamic> responseData = dioResponse.data;
          final List<Brand> brands =
              responseData.map((brand) => Brand.fromJson(brand)).toList();

          return brands;
        } else {
          return [];
        }
      } else {
        throw Exception('Error request exception');
      }
    } catch (e) {
      throw Exception('Failed to fetch cars: $e');
    }
  }
  
}
