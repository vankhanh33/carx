import 'package:carx/data/model/user.dart';
import 'package:equatable/equatable.dart';

enum FetchUserStatus { initial, loading, success, failure }

class PersonalState extends Equatable {
  final User? user;
  final FetchUserStatus fetchUserStatus;
  const PersonalState({required this.user, required this.fetchUserStatus});
  const PersonalState.initial()
      : user = null,
        fetchUserStatus = FetchUserStatus.initial;

  PersonalState copyWith({
    User? user,
    FetchUserStatus? fetchUserStatus,
  }) =>
      PersonalState(
        user: user ?? this.user,
        fetchUserStatus: fetchUserStatus ?? this.fetchUserStatus,
      );
  @override
  List<Object?> get props => [user, fetchUserStatus];
}
