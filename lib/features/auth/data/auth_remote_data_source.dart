import 'dart:io';

abstract class AuthRemoteDataSource {
  Future<void> signUp({
    required File profileImage,
    required String email,
    required String password,
    required String name,
    required String phone,
    required String additionalInfo,
  });

  Future<void> login({required String email, required String password});
  Future<void> resetPassword(String email);
  Future<void> logout();
}
