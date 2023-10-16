abstract class CarDetailEvent {}

class FetchCarDetailEvent extends CarDetailEvent {
  final int carId;
  FetchCarDetailEvent({required this.carId});
}
