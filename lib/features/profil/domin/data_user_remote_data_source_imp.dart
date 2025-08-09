import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carraze/core/models/user_model.dart';
import 'data_user_remote_data_source.dart';

class DataUserRemoteDataSourceImpl implements DataUserRemoteDataSource {
  final FirebaseFirestore firestore;

  DataUserRemoteDataSourceImpl({FirebaseFirestore? firestoreInstance})
    : firestore = firestoreInstance ?? FirebaseFirestore.instance;

  @override
  Future<UserModel> getUserInfo(String userId) async {
    try {
      final doc = await firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        print("🔥 Raw Firestore user data: $data");
        return UserModel.fromMap(data);
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
  }

  @override
  Future<void> updateUserInfo(String userId, UserModel user) async {
    try {
      await firestore.collection('users').doc(userId).update(user.toMap());
    } catch (e) {
      throw Exception("Failed to update user info: $e");
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await firestore.collection('users').doc(userId).delete();
    } catch (e) {
      throw Exception("Failed to delete user: $e");
    }
  }
}
