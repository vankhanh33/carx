import 'dart:convert';

import 'package:carx/data/model/dio_response.dart';
import 'package:carx/data/model/distributor_model.dart';
import 'package:carx/service/api/api_constants.dart';
import 'package:carx/service/dio/dio_client.dart';
import 'package:dio/dio.dart';

class UserRequest {
  final Dio dio;
  const UserRequest({required this.dio});
  factory UserRequest.request() => UserRequest(dio: DioClient.instance.dio);

  Future<DistributorModel> fetchDistributor(int carId) async {
    final response = await dio.post(
      pathDistributor,
      data: FormData.fromMap({'id': carId}),
    );
    if (response.statusCode == 200) {
      DioResponse dioResponse = DioResponse.fromJson(jsonDecode(response.data));
      if (dioResponse.status == 'OK') {
        DistributorModel distributorModel =
            DistributorModel.fromJson(dioResponse.data);
        return distributorModel;
      } else {
        throw Exception('Not found distributor');
      }
    } else {
      throw Exception('Error');
    }
  }
}
