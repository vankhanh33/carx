import 'dart:convert';
import 'dart:io';

import 'package:carx/data/model/dio_response.dart';
import 'package:carx/utilities/api_constants.dart';
import 'package:carx/service/auth/auth_exceptions.dart';
import 'package:carx/service/client/dio_client.dart';
import 'package:dio/dio.dart';

import 'package:carx/data/model/user.dart';
import 'package:carx/data/reponsitories/auth/auth_reponsitory.dart';

class AuthReponsitoryImpl implements AuthReponsitory {
  final Dio _dio;

  const AuthReponsitoryImpl(this._dio);
  factory AuthReponsitoryImpl.reponsitory() =>
      AuthReponsitoryImpl(DioClient.instance.dio);

  @override
  Future<void> createOrUpdateUser(
      {required String id,
      String? name,
      String? email,
      String? image,
      String? token}) async {
    try {
      User user =
          User(id: id, email: email, name: name, image: image, token: token);

      final userJson = user.toJson();

      final reponse = await _dio.post(
        REGISTER,
        data: FormData.fromMap(userJson),
      );
      if (reponse.statusCode != 200) {
        throw GenericAuthException();
      }
    } catch (e) {
      throw (Exception('Error'));
    }
  }

  @override
  Future<User> fetUserById(String uId) async {
    try {
      final reponse = await _dio.post(
        FETCH_USER_BY_ID,
        data: FormData.fromMap({'id': uId}),
      );
      if (reponse.statusCode == 200) {
        DioReponse dioResponse = DioReponse.fromJson(jsonDecode(reponse.data));

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

  @override
  Future<void> updateUserInfomation(User user, File? imageFile) async {
    try {
      Map<String, dynamic> userMap = await user.toJsonImageFile(imageFile);
      final response = await _dio.post(
        UPDATE_USER_INFO,
        data: FormData.fromMap(userMap),
      );
      if(response.statusCode == 200){
        print('Success ${response.data}');
      }else{
        print('Failled');
      }
    } catch (e) {
      throw (Exception('Error'));
    }
  }
}
