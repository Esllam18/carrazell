import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Initial State
class AuthInitial extends AuthState {}

// Loading State
class AuthLoading extends AuthState {}

// Success States
class SignUpSuccess extends AuthState {}

class LoginSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class LogoutSuccess extends AuthState {}

// Error State
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
