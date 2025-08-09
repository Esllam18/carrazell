import 'package:carraze/core/models/user_model.dart';

abstract class DataUserRemoteDataSource {
  Future<UserModel> getUserInfo(String userId);
  Future<void> updateUserInfo(String userId, UserModel user);
  Future<void> deleteUser(String userId);
}
