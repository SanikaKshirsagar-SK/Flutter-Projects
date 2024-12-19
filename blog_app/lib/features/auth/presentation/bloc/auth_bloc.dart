import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _userSignUp;
  final LoginUsecase _userLogin;
  final CurrentUserUsecase _currentUserUsecase;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required SignUpUseCase userSignUp,
    required LoginUsecase userLogin,
    required CurrentUserUsecase currentUserUsecase,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUserUsecase = currentUserUsecase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthLoginEvent>(_onLogin);
    on<AuthIsLoggedInEvent>(_onLoggedIn);
  }

  void _onSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final response = await _userSignUp(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));
    response.fold((faliure) => emit(AuthFailure(faliure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final response = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    response.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onLoggedIn(AuthIsLoggedInEvent event, Emitter<AuthState> emit) async {
    final response = await _currentUserUsecase(NoParams());
    response.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
