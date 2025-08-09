import 'dart:io';
import 'package:carraze/features/auth/data/auth_reposittory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> signUp({
    required File profileImage,
    required String email,
    required String password,
    required String name,
    required String phone,
    required String additionalInfo,
  }) async {
    emit(AuthLoading());
    try {
      await authRepository.signUp(
        profileImage: profileImage,
        email: email,
        password: password,
        name: name,
        phone: phone,
        additionalInfo: additionalInfo,
      );
      emit(SignUpSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await authRepository.login(email: email, password: password);
      emit(LoginSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await authRepository.resetPassword(email: email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
