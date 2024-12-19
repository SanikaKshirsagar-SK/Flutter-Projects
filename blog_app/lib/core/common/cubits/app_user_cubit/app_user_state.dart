part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedInState extends AppUserState {
  final UserEntity user;
  AppUserLoggedInState(this.user);
}
