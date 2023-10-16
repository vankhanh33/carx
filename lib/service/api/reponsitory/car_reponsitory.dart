// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:carx/data/model/car.dart';

import 'package:carx/data/model/detail.dart';
import 'package:carx/data/model/dio_response.dart';
import 'package:carx/service/api/api_constants.dart';

import 'package:carx/service/dio/dio_client.dart';
import 'package:dio/dio.dart';

class CarReponsitory {
  final Dio dio;
  const CarReponsitory(this.dio);

  factory CarReponsitory.response() => CarReponsitory(DioClient.instance.dio);

  Future<List<Car>> fetchCarByBrand(String brand) async {
    try {
      final response = await dio.post(
        getCarByBrand,
        data: FormData.fromMap({'brand_name': brand}),
      );
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
      throw Exception('Error request exception');
    }
  }

  Future<List<Car>> fetchCars() async {
    try {
      final response = await dio.get(getCar);
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

 static Future<List<String>> getSuggestions(String text, List<Car> cars) async {
    List<String> names = cars.map((e) => e.name).toList();
    List<String> suggestions = names
        .where((e) => e.toLowerCase().startsWith(text.toLowerCase()))
        .toList();
    return suggestions;
  }

  Future<Detail> fetchCarDetails(int id) async {
    try {
      final response = await dio.post(
        carDetail,
        data: FormData.fromMap(<String, dynamic>{'id': id}),
      );
      if (response.statusCode == 200) {
        DioResponse dioResponse =
            DioResponse.fromJson(jsonDecode(response.data));
        if (dioResponse.status == 'OK') {
          Detail cars = Detail.fromJson(dioResponse.data);
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
}
