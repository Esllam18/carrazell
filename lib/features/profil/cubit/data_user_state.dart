import 'package:carraze/core/models/user_model.dart';

abstract class DataUserState {}

class DataUserInitial extends DataUserState {}

class DataUserLoading extends DataUserState {}

class DataUserLoaded extends DataUserState {
  final UserModel user;
  DataUserLoaded(this.user);
}

class DataUserError extends DataUserState {
  final String message;

  DataUserError(this.message);
}

class DataUserUpdated extends DataUserState {}

class DataUserDeleted extends DataUserState {}
