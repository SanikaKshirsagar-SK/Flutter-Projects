import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUseCase implements Usecase<UserEntity, UserSignUpParams> {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(UserSignUpParams params) async{
    return await authRepository.signUpWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  String name;
  String email;
  String password;
  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
