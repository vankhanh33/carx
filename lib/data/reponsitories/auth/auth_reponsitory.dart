import 'dart:io';

import 'package:carx/data/model/user.dart';

abstract class AuthReponsitory {
  Future<void> createOrUpdateUser({
    required String id,
    String? name,
    String? email,
    String? image,
    String? token,
  });
  Future<User> fetUserById(String uId);
  Future<void> updateUserInfomation(User user, File? imageFile);
}
