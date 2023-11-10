import 'package:carx/data/model/delivery_address.dart';

abstract class DeliveryAddressEvent {}

class FetchDeliveryAddressesEvent extends DeliveryAddressEvent {}

class DeliveryAddressSelectionEvent extends DeliveryAddressEvent {
  final DeliveryAddress? deliveryAddress;
  DeliveryAddressSelectionEvent({required this.deliveryAddress});
}
