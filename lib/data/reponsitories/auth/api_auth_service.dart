import 'dart:io';

import 'package:carx/data/model/delivery_address.dart';
import 'package:carx/data/model/user.dart';
import 'package:carx/data/reponsitories/auth/auth_reponsitory.dart';
import 'package:carx/data/reponsitories/auth/auth_reponsitory_impl.dart';

class ApiAuthService implements AuthReponsitory {
  final AuthReponsitory authReponsitory;
  const ApiAuthService({required this.authReponsitory});
  factory ApiAuthService.fromApi() =>
      ApiAuthService(authReponsitory: AuthReponsitoryImpl.reponsitory());

  @override
  Future<void> createOrUpdateUser(
          {required String id,
          String? name,
          String? email,
          String? image,
          String? token}) =>
      authReponsitory.createOrUpdateUser(
          id: id, name: name, email: email, image: image, token: token);

  @override
  Future<User> fetUserById(String uId) async =>
      authReponsitory.fetUserById(uId);

  @override
  Future<void> updateUserInfomation(User user, File? imageFile) =>
      authReponsitory.updateUserInfomation(user, imageFile);

  @override
  Future<DeliveryAddress?> fetchDeliveryAddressDefault(String uId) =>
      fetchDeliveryAddressDefault(uId);

  @override
  Future<List<DeliveryAddress>> fetchDeliveryAddresses(String uId) =>
      fetchDeliveryAddresses(uId);

  @override
  Future<void> addDeliveryAddress(
          String uId, DeliveryAddress deliveryAddress) =>
      addDeliveryAddress(uId, deliveryAddress);

  @override
  Future<void> deleteDeliveryAddress(String id) => deleteDeliveryAddress(id);
}
