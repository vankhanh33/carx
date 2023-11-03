import 'package:carx/data/model/brand.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/data/model/order.dart';
import 'package:equatable/equatable.dart';

class OrderManagement extends Equatable {
  final Car car;
  final Brand brand;
  final Order order;

  const OrderManagement({
    required this.car,
    required this.brand,
    required this.order,
  });

  factory OrderManagement.fromJson(Map<String, dynamic> json) =>
      OrderManagement(
        car: Car.fromJson(json['car']),
        brand: Brand.fromJson(json['brand']),
        order: Order.fromJson(json['order']),
      );

  @override
 
  List<Object?> get props => [car, brand, order];
}
