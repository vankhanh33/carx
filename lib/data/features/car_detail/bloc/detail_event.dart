import 'package:carx/data/model/car.dart';

abstract class CarDetailEvent {}

class FetchCarDetailEvent extends CarDetailEvent {
  final Car car;
  FetchCarDetailEvent({required this.car});
}

class CheckCarFavoriteEvent extends CarDetailEvent {
  final int carId;
  CheckCarFavoriteEvent(this.carId);
}

class AddOrDeleteCarFavoriteEvent extends CarDetailEvent {
  final Car car;
  AddOrDeleteCarFavoriteEvent(this.car);
}
