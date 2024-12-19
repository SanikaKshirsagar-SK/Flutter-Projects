import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentUserSession != null) {
        final userdata = await supabaseClient
            .from("UserData")
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userdata.first)
            .copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      if (response.user == null) {
        throw ServerException("User is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(email: email, password: password, data: {'name': name});
      if (response.user == null) {
        throw ServerException("User is null..");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
