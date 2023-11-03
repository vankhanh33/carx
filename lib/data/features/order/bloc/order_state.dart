import 'package:carx/data/model/car.dart';

class OrderState {
  final int delivery;
  final String address;
  final DateTime? startTime;
  final DateTime? endTime;
  final int rentalDuration;
  final int totalAmount;
  final int price;
  final bool isLoading;
  final Car? car;

  OrderState({
    required this.delivery,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.rentalDuration,
    required this.totalAmount,
    required this.isLoading,
    required this.car,
  });

  OrderState.initial()
      : delivery = 0,
        address = '',
        startTime = null,
        endTime = null,
        price = 0,
        rentalDuration = 1,
        totalAmount = 0,
        isLoading = false,
        car = null;

  OrderState copyWith({
    int? delivery,
    String? address,
    String? payment,
    DateTime? startTime,
    DateTime? endTime,
    int? price,
    int? rentalDuration,
    int? totalAmount,
    bool? isLoading,
    Car? car,
  }) {
    return OrderState(
      delivery: delivery ?? this.delivery,
      address: address ?? this.address,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      price: price ?? this.price,
      rentalDuration: rentalDuration ?? this.rentalDuration,
      totalAmount: totalAmount ?? this.totalAmount,
      isLoading: isLoading ?? this.isLoading,
      car: car ?? this.car,
    );
  }
}
