import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUserUsecase implements Usecase {
  final AuthRepository authRepository;
  CurrentUserUsecase(this.authRepository);
  @override
  Future<Either<Failure, dynamic>> call(params) {
    return authRepository.currentUser();
  }
}
