import 'dart:convert';

import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/car_detail.dart';
import 'package:carx/data/model/dio_response.dart';
import 'package:carx/service/api/api_constants.dart';
import 'package:carx/service/dio/dio_client.dart';
import 'package:dio/dio.dart';

class CarRequest {
  final Dio dio;
  const CarRequest(this.dio);

  factory CarRequest.dio() => CarRequest(DioClient.instance.dio);

  Future<List<Car>> fetchCarByBrand(String brand) async {
    final query = {'brand_name': brand};
    final response = await dio.post(
      getCarByBrand,
      data: FormData.fromMap(query),
    );
    if (response.statusCode == 200) {
      DioResponse dioResponse = DioResponse.fromJson(jsonDecode(response.data));

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
  }

  Future<List<Car>> fetchCars() async {
    final response = await dio.get(getCarByBrand);
    if (response.statusCode == 200) {
      DioResponse dioResponse = DioResponse.fromJson(jsonDecode(response.data));

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
  }

  Future<CarDetail> fetchCarDetails(int id) async {
    final response = await dio.post(
      carDetail,
      data: FormData.fromMap(<String, dynamic>{'id': id}),
    );
    if (response.statusCode == 200) {
      DioResponse dioResponse = DioResponse.fromJson(jsonDecode(response.data));
      if (dioResponse.status == 'OK') {
        CarDetail cars = CarDetail.fromJson(dioResponse.data);
        return cars;
      } else {
        throw Exception('Not found');
      }
    } else {
      throw Exception('Error request exception');
    }
  }

}
