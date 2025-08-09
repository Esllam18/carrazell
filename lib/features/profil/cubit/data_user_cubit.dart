import 'package:carraze/core/models/user_model.dart';
import 'package:carraze/features/profil/cubit/data_user_state.dart';
import 'package:carraze/features/profil/data/data_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataUserCubit extends Cubit<DataUserState> {
  final DataUserRepository repository;

  DataUserCubit(this.repository) : super(DataUserInitial());

  Future<void> getUserInfo() async {
    final userId = repository.getCurrentUserId(); // Assuming this method exists
    emit(DataUserLoading());
    try {
      final user = await repository.getUserInfo(userId);
      emit(DataUserLoaded(user));
    } catch (e) {
      print('Error fetching user info: $e');
      emit(DataUserError(e.toString()));
    }
  }

  Future<void> updateUserInfo(String userId, UserModel user) async {
    emit(DataUserLoading());
    try {
      await repository.updateUserInfo(userId, user);
      emit(DataUserUpdated());
    } catch (e) {
      emit(DataUserError("Failed to update user info: ${e.toString()}"));
    }
  }

  Future<void> deleteUser(String userId) async {
    emit(DataUserLoading());
    try {
      await repository.deleteUser(userId);
      emit(DataUserDeleted());
    } catch (e) {
      emit(
        DataUserError(
          "Failed to delete user"
          " info: ${e.toString()}",
        ),
      );
    }
  }
}
