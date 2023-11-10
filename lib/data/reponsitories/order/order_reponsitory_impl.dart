import 'dart:convert';

import 'package:carx/data/model/dio_response.dart';
import 'package:carx/data/model/order.dart';
import 'package:carx/data/model/order_management.dart';
import 'package:carx/data/reponsitories/order/order_reponsitory.dart';

import 'package:carx/service/client/dio_client.dart';
import 'package:carx/utilities/api_constants.dart';
import 'package:carx/utilities/notification/notification_service.dart';
import 'package:dio/dio.dart';

class OrderReponsitoryImpl implements OrderReponsitory {
  final Dio _dio;

  const OrderReponsitoryImpl(this._dio);
  factory OrderReponsitoryImpl.response() =>
      OrderReponsitoryImpl(DioClient.instance.dio);

  @override
  Future<void> addOrder(Order order) async {
    try {
      final response = await _dio.post(
        ADD_CAR_ORDER,
        data: FormData.fromMap(order.toJson()),
      );
      if (response.statusCode == 200) {
        DioReponse dioResponse = DioReponse.fromJson(jsonDecode(response.data));
        if (dioResponse.status == 'OK') {
          int id = int.parse(dioResponse.data);
          String token = await fetchTokenDistributor(orderId: id);
          NotificationService notificationService = NotificationService();
          notificationService.sendNotificationToDevice(
              token, 'Đơn hàng mới', 'Bạn có đơn hàng mới');
        }
      }
    } catch (e) {
      throw Exception('Error Sever ${e.toString()}');
    }
  }

  @override
  Future<List<OrderManagement>> fetchOrders(String uId) async {
    try {
      final reponse = await _dio.post(
        ORDER_MANAGEMENT,
        data: FormData.fromMap({'user_id': uId}),
      );
      if (reponse.statusCode == 200) {
        DioReponse dioReponse = DioReponse.fromJson(jsonDecode(reponse.data));

        if (dioReponse.status == 'OK') {
          List<dynamic> reponseData = dioReponse.data;
          List<OrderManagement> orders = reponseData
              .map((data) => OrderManagement.fromJson(data))
              .toList();
          return orders;
        } else {
          return [];
        }
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception('Error Sever');
    }
  }

  @override
  Future<String> fetchTokenDistributor({required int orderId}) async {
    try {
      final response = await _dio.post(
        FETCH_TOKEN_DISTRIBUTOR,
        data: FormData.fromMap(<String, dynamic>{'id': orderId}),
      );
      if (response.statusCode == 200) {
        DioReponse dioResponse = DioReponse.fromJson(jsonDecode(response.data));
        if (dioResponse.status == 'OK') {
          String token = dioResponse.data;
          return token;
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

  @override
  Future<void> updateOrder({
    required Order order,
    required String status,
    String? paymentStatus,
  }) async {
    try {
      final response = await _dio.post(
        UPDATE_STATUS_ORDER,
        data: FormData.fromMap({
          'id': order.id,
          'status': status,
          'payment_status': paymentStatus ?? order.paymentstatus,
        }),
      );
      if (response.statusCode == 200) {
        DioReponse dioResponse = DioReponse.fromJson(jsonDecode(response.data));
        if (dioResponse.status == 'OK') {
          if (paymentStatus == 'Cancellled') {
            int id = int.parse(dioResponse.data);
            String token = await fetchTokenDistributor(orderId: id);
            NotificationService notificationService = NotificationService();
            notificationService.sendNotificationToDevice(
                token, 'Đơn hàng bị hủy', 'Đơn hàng ${order.code} bị hủy');
          }
        }
      }
    } catch (e) {
      throw Exception('Error Sever ${e.toString()}');
    }
  }
}
