import 'package:carx/data/features/personal/bloc/personal_event.dart';
import 'package:carx/data/features/personal/bloc/personal_state.dart';
import 'package:carx/data/reponsitories/auth/auth_reponsitory.dart';
import 'package:carx/service/auth/auth_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc(AuthReponsitory authReponsitory, AuthProvider provider)
      : super(const PersonalState.initial()) {
    on<FetchUserEvent>(
      (event, emit) async {
        emit(state.copyWith(fetchUserStatus: FetchUserStatus.loading));
        try {
          final uid = provider.currentUser?.id;

          final user = await authReponsitory.fetUserById(uid!);

          emit(state.copyWith(
              user: user, fetchUserStatus: FetchUserStatus.success));
        } catch (e) {
          emit(state.copyWith(fetchUserStatus: FetchUserStatus.failure));
        }
      },
    );
     on<UpdateUserEvent>(
      (event, emit)  {
        emit(state.copyWith(user: event.user));
      });
  }
}
