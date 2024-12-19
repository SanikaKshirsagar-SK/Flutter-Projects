part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  String name;
  String email;
  String password;
  AuthSignUpEvent(
      {required this.name, required this.email, required this.password});
}

class AuthLoginEvent extends AuthEvent {
  String email;
  String password;
  AuthLoginEvent({required this.email, required this.password});
}


class AuthIsLoggedInEvent extends AuthEvent{}