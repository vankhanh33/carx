import 'package:carx/data/model/order.dart';

class OrderManagementDetailEvent {}

class OrderCancellationEvent extends OrderManagementDetailEvent {
  final Order order;
  OrderCancellationEvent({required this.order});
}
