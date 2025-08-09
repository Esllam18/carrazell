import 'package:carraze/core/models/user_model.dart';
import 'package:carraze/features/profil/data/data_user_repository.dart';
import 'package:carraze/features/profil/domin/data_user_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataUserRepositoryImpl implements DataUserRepository {
  final DataUserRemoteDataSource remoteDataSource;

  DataUserRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> deleteUser(String userId) {
    return remoteDataSource.deleteUser(userId);
  }

  @override
  Future<UserModel> getUserInfo(String userId) {
    return remoteDataSource.getUserInfo(userId);
  }

  @override
  Future<void> updateUserInfo(String userId, UserModel user) {
    return remoteDataSource.updateUserInfo(userId, user);
  }

  @override
  String getCurrentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
