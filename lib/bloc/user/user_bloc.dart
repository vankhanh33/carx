import 'package:bloc/bloc.dart';
import 'package:carx/bloc/user/user_event.dart';
import 'package:carx/bloc/user/user_state.dart';
import 'package:carx/data/model/user.dart';
import 'package:carx/service/api/reponsitory/reponsitory.dart';
import 'package:carx/service/auth/auth_provider.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(Reponsitory reponsitory,AuthProvider provider) : super(UserInitial()) {
    on<FetchUser>(
      (event, emit) async {
        emit(UserLoading());
        try {
          final uid = provider.currentUser?.id;
        
          final User user = await reponsitory.fetUserById(uid!);
         
          emit(UserSuccess(user: user));
        } catch (e) {
          emit(UserFailure(error: e.toString()));
        }
      },
    );
  }
}
