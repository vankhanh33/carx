import 'dart:convert';

import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/car_detail.dart';

import 'package:carx/data/model/dio_response.dart';
import 'package:carx/data/model/distributor.dart';

import 'package:carx/service/client/dio_client.dart';
import 'package:carx/utilities/api_constants.dart';
import 'package:dio/dio.dart';

class CarReponsitory {
  final Dio _dio;
  const CarReponsitory(this._dio);

  factory CarReponsitory.response() => CarReponsitory(DioClient.instance.dio);

  Future<List<Car>> fetchCars() async {
    try {
      final reponse = await _dio.get(FETCH_ALL_CAR);
      if (reponse.statusCode == 200) {
        DioReponse dioResponse = DioReponse.fromJson(jsonDecode(reponse.data));

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

  Future<List<Car>> fetchCarsByBrand(int brandId) async {
    try {
      final reponse = await _dio.post(
        FETCH_CARS_BY_BRAND,
        data: FormData.fromMap({'brand_id': brandId}),
      );
      if (reponse.statusCode == 200) {
        DioReponse dioResponse = DioReponse.fromJson(jsonDecode(reponse.data));

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
      final reponse = await _dio.get(FETCH_ALL_BRAND);
      if (reponse.statusCode == 200) {
        DioReponse dioResponse = DioReponse.fromJson(jsonDecode(reponse.data));

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

  static Future<List<String>> getSuggestions(
      String text, List<Car> cars) async {
    List<String> names = cars.map((e) => e.name).toList();
    List<String> suggestions = names
        .where((e) => e.toLowerCase().startsWith(text.toLowerCase()))
        .toList();
    return suggestions;
  }

  Future<CarDetail> fetchCarDetailsByCarId(int id) async {
    try {
      final response = await _dio.post(
        FETCH_CAR_DETAIL,
        data: FormData.fromMap(<String, dynamic>{'id': id}),
      );
      if (response.statusCode == 200) {
        DioReponse dioResponse = DioReponse.fromJson(jsonDecode(response.data));
        if (dioResponse.status == 'OK') {
          CarDetail cars = CarDetail.fromJson(dioResponse.data);
          return cars;
        } else {
          throw Exception('Not found');
        }
      } else {
        throw Exception('Error request exception');
      }
    } catch (e) {
      throw Exception('Error exception $e');
    }
  }

  Future<Distributor> fetchDistributorByCarId(int id) async {
    try {
      final response = await _dio.post(
        FETCH_DISTRIBUTOR,
        data: FormData.fromMap(<String, dynamic>{'id': id}),
      );
      if (response.statusCode == 200) {
        DioReponse dioResponse = DioReponse.fromJson(jsonDecode(response.data));
        if (dioResponse.status == 'OK') {
          Distributor distributor = Distributor.fromJson(dioResponse.data);
          return distributor;
        } else {
          throw Exception('Not found');
        }
      } else {
        throw Exception('Error request exception');
      }
    } catch (e) {
      throw Exception('Error exception $e');
    }
  }
}
