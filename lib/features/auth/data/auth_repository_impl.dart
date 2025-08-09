import 'dart:io';

import 'package:carraze/features/auth/data/auth_remote_data_source.dart';
import 'package:carraze/features/auth/data/auth_reposittory.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> signUp({
    required File profileImage,
    required String email,
    required String password,
    required String name,
    required String phone,
    required String additionalInfo,
  }) {
    return remoteDataSource.signUp(
      profileImage: profileImage,
      email: email,
      password: password,
      name: name,
      phone: phone,
      additionalInfo: additionalInfo,
    );
  }

  @override
  Future<void> login({required String email, required String password}) {
    return remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }

  @override
  Future<void> resetPassword({required String email}) {
    return remoteDataSource.resetPassword(email);
  }
}
