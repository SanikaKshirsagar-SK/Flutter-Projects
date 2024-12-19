part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  UserEntity user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  String message;
  AuthFailure(this.message);
}
