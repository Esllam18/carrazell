import 'dart:io';

import 'package:carraze/core/models/user_model.dart';
import 'package:carraze/features/auth/data/auth_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<void> signUp({
    required File profileImage,
    required String email,
    required String password,
    required String name,
    required String phone,
    required String additionalInfo,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final ref = _storage.ref().child('users_images').child('$email.jpg');
    await ref.putFile(profileImage);
    final imageUrl = await ref.getDownloadURL();

    final userModel = UserModel(
      uid: userCredential.user!.uid,
      email: email,
      name: name,
      phone: phone,
      additionalInfo: additionalInfo,
      imageUrl: imageUrl,
    );

    await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(userModel.toMap());
  }

  @override
  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user!.uid;
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> logout() {
    return _auth.signOut();
  }
}
