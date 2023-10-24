import 'dart:convert';

import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/dio_response.dart';
import 'package:carx/data/model/order.dart';
import 'package:carx/data/model/user.dart';
import 'package:carx/service/api/api_constants.dart';
import 'package:carx/service/dio/dio_client.dart';
import 'package:dio/dio.dart';

class Reponsitory {
  final Dio _dio;

  const Reponsitory(this._dio);
  factory Reponsitory.response() => Reponsitory(DioClient.instance.dio);

  Future<List<Car>> fetchCars() async {
    try {
      final reponse = await _dio.get(getCar);
      if (reponse.statusCode == 200) {
        DioResponse dioResponse =
            DioResponse.fromJson(jsonDecode(reponse.data));

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
      final reponse = await _dio.get(getBrand);
      if (reponse.statusCode == 200) {
        DioResponse dioResponse =
            DioResponse.fromJson(jsonDecode(reponse.data));

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

  Future<User> fetUserById(String uId) async {
    try {
      final reponse = await _dio.post(
        getUserId,
        data: FormData.fromMap({'id': uId}),
      );
      if (reponse.statusCode == 200) {
        DioResponse dioResponse =
            DioResponse.fromJson(jsonDecode(reponse.data));

        if (dioResponse.status == 'OK') {
          final User user = User.fromJson(dioResponse.data);
          return user;
        } else {
          throw Exception('Not found user');
        }
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception('Error Sever');
    }
  }

  Future<void> addOrder(Order order) async {
    try {
      await _dio.post(
        addCarOrder,
        data: FormData.fromMap(order.toJson()),
      );

      // if (reponse.statusCode == 200) {
      //   final result = jsonDecode(reponse.data);

      // } else {
      //   throw Exception('Error');
      // }
    } catch (e) {
      throw Exception('Error Sever ${e.toString()}');
    }
  }
}
