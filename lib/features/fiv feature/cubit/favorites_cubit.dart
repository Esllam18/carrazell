import 'package:carraze/core/models/fiv_car.dart';
import 'package:carraze/features/fiv%20feature/cubit/favorites_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FavoritesCubit() : super(FavoritesInitial()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        emit(FavoritesError('No authenticated user found'));
        return;
      }

      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .get();

      final favorites = snapshot.docs
          .map((doc) => FavoriteCar.fromMap(doc.data()))
          .toList();

      emit(FavoritesUpdated(favorites));
    } catch (e) {
      emit(FavoritesError('Failed to fetch favorites: ${e.toString()}'));
    }
  }

  Future<void> addFavorite(FavoriteCar car) async {
    emit(FavoritesLoading());
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        emit(FavoritesError('No authenticated user found'));
        return;
      }

      final favorites = List<FavoriteCar>.from(
        state is FavoritesUpdated ? (state as FavoritesUpdated).favorites : [],
      );

      if (!favorites.any((item) => item.id == car.id)) {
        favorites.add(car);

        await _firestore
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .doc(car.id)
            .set(car.toMap());
      }

      emit(FavoritesUpdated(favorites));
    } catch (e) {
      emit(FavoritesError('Failed to add favorite: ${e.toString()}'));
    }
  }

  Future<void> removeFavoriteById(String id) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        emit(FavoritesError('No authenticated user found'));
        return;
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(id)
          .delete();

      final favorites = List<FavoriteCar>.from(
        state is FavoritesUpdated ? (state as FavoritesUpdated).favorites : [],
      );
      favorites.removeWhere((item) => item.id == id);

      emit(FavoritesUpdated(favorites));
    } catch (e) {
      emit(FavoritesError("Failed to remove favorite: ${e.toString()}"));
    }
  }
}
