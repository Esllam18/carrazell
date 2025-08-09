import 'dart:io';

abstract class AuthRepository {
  Future<void> signUp({
    required File profileImage,
    required String email,
    required String password,
    required String name,
    required String phone,
    required String additionalInfo,
  });

  Future<void> login({required String email, required String password});
  Future<void> logout();

  Future<void> resetPassword({required String email});
}
