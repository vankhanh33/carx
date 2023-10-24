import 'package:carx/data/model/car.dart';

abstract class CarDetailEvent {}

class FetchCarDetailEvent extends CarDetailEvent {
  final Car car;
  FetchCarDetailEvent({required this.car});
}
