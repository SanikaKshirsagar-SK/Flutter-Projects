import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsecase implements Usecase<UserEntity, UserLoginParams> {
  final AuthRepository authRepository;
  LoginUsecase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  String email;
  String password;

  UserLoginParams({required this.email, required this.password});
}
