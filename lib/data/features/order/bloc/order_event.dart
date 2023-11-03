import 'package:carx/data/model/car.dart';
import 'package:flutter/material.dart';

class OrderEvent {}

class DeliveryUpdated extends OrderEvent {
  final int delivery;

  DeliveryUpdated(this.delivery);
}

class AddressUpdated extends OrderEvent {
  final String? address;

  AddressUpdated(this.address);
}

class FromTimeUpdated extends OrderEvent {
  BuildContext context;
  FromTimeUpdated(this.context);
}

class EndTimeUpdated extends OrderEvent {
  BuildContext context;
  int pricePerDay;
  EndTimeUpdated(this.context, this.pricePerDay);
}

class CarUpdated extends OrderEvent {
  final Car car;

  CarUpdated(this.car);
}

class PriceUpdated extends OrderEvent {
  final int price;

  PriceUpdated(this.price);
}

class OrderButtonClicked extends OrderEvent {
  final BuildContext context;

  OrderButtonClicked(this.context);
}
