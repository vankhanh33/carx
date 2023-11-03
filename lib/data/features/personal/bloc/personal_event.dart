import 'package:carx/data/model/user.dart';
import 'package:equatable/equatable.dart';

abstract class PersonalEvent extends Equatable {}

class FetchUserEvent extends PersonalEvent {
  @override
  List<Object?> get props => [];
}
class UpdateUserEvent extends PersonalEvent {
  final User? user;
  UpdateUserEvent({this.user});
  @override
  List<Object?> get props => [user];
}
