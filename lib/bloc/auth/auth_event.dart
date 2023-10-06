import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitalize extends AuthEvent {
  const AuthEventInitalize();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogIn({required this.email, required this.password});
}

class AuthEventLogInWithGoogle extends AuthEvent {
  const AuthEventLogInWithGoogle();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String confirmPassword;

  const AuthEventRegister({
    required this.email,
    required this.password,
    required this.name,
    required this.confirmPassword,
  });
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventForgotPassword extends AuthEvent {
  final String? email;
  const AuthEventForgotPassword({this.email});
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
