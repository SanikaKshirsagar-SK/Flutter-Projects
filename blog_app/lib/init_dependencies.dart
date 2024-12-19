import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/secrets/supabase_secrets.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: SupabaseSecrets.supabaseUrl,
      anonKey: SupabaseSecrets.supabaseAnnonKey);

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignUpUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => LoginUsecase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUserUsecase(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => AuthBloc(
          userSignUp: serviceLocator(),
          userLogin: serviceLocator(),
          currentUserUsecase: serviceLocator(),
          appUserCubit: serviceLocator(),
        ));
}
