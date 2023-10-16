// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/service/api/api_constants.dart';
import 'package:carx/service/api/api_service.dart';
import 'package:carx/service/api/request/car_request.dart';
import 'package:http/http.dart' as http;
import 'package:carx/data/model/user.dart';
import 'package:carx/service/api/api_provider.dart';

class HttpApiProvider implements ApiProvider {
  @override
  Future<void> createUser({
    required String id,
    required String name,
    required String email,
  }) async {
    User user = User(id: id, email: email, name: name);
    final userJson = user.toJson();
    await http.post(Uri.parse(URL_REGISTER), body: userJson);
    // if (reponse.statusCode == 200) {
    //   print('Success');
    // } else {
    //   print("failed");
    // }
  }

  @override
  Future<void> createUserWithGoogle({
    required String id,
    String? name,
    String? email,
    String? image,
  }) async {
    User user = User(id: id, email: email, name: name, image: image);
    final userJson = user.toJson();
    await http.post(Uri.parse(URL_REGISTER), body: userJson);
  }

  @override
  Future<List<Brand>> fetchBrands() async {
    final response = await http.get(Uri.parse(getBrand));
    if (response.statusCode == 200) {
      final Map<String, dynamic> mapReponse = jsonDecode(response.body);
      if (mapReponse['status'] == 'OK') {
        final List<dynamic> responseData = mapReponse['data'];
        final List<Brand> brands =
            responseData.map((data) => Brand.fromJson(data)).toList();

        return brands;
      } else
        return [];
    } else {
      throw Exception('Failed to fetch brands');
    }
  }

  @override
  Future<List<Car>> fetchCars() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    final response = await http.get(
      Uri.parse(getCar),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> mapReponse = jsonDecode(response.body);
      if (mapReponse['status'] == 'OK') {
        final List<dynamic> responseData = mapReponse['data'];
        final List<Car> cars =
            responseData.map((data) => Car.fromJson(data)).toList();

        return cars;
      } else
        return [];
    } else {
      throw Exception('Failed to fetch Cars');
    }
  }

  @override
  Future<List<Car>> fetchCarByBrand({required String brand}) {
    // Map<String, dynamic> mapBrand = {'brand_name': brand};
    // final response = await http.post(
    //   Uri.parse(getCarByBrand),
    //   body: mapBrand,
    // );

    // if (response.statusCode == 200) {
    //   final Map<String, dynamic> mapReponse = jsonDecode(response.body);
    //   if (mapReponse['status'] == 'OK') {
    //     final List<dynamic> responseData = mapReponse['data'];
    //     final List<Car> cars =
    //         responseData.map((data) => Car.fromJson(data)).toList();

    //     return cars;
    //   } else
    //     return [];
    // } else {
    //   throw Exception('Failed to fetch Cars');
    // }
    return CarRequest.dio().fetchCarByBrand(brand);
  }
}
