import 'package:carx/service/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;
  Future<AuthUser> loginWithEmail({
    required String email,
    required String password,
  });
  Future<AuthUser> loginWithPhone({required String phone});
  Future<AuthUser> createUserWithEmail(
      {required String email,
      required String password,
      required String name,
      required String confirmPassword});

  Future<AuthUser> loginWithGoogle();

  Future<void> logOut();
  Future<void> sendPasswordResetWithEmail({required String email});
  Future<void> sendPasswordResetWithPhone({required String phone});
}
