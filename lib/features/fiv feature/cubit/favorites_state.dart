import 'package:carraze/core/models/fiv_car.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesUpdated extends FavoritesState {
  final List<FavoriteCar> favorites;
  FavoritesUpdated(this.favorites);
}

class FavoritesLoading extends FavoritesState {}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}
