import 'package:carx/data/model/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserSuccess extends UserState {
  final User user;

  UserSuccess({required this.user});
  @override
  List<Object?> get props => [user];
}

class UserFailure extends UserState {
  final String error;

  UserFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
