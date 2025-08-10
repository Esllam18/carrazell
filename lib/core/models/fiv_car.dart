import 'package:carraze/core/models/car_model.dart';

class FavoriteCar {
  final String imageUrl;
  final String id;
  final String name;
  final String model;
  final int year;

  FavoriteCar({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.model,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'year': year,
      'imageUrl': imageUrl,
    };
  }

  factory FavoriteCar.fromMap(Map<String, dynamic> map) {
    return FavoriteCar(
      id: map['id'],
      name: map['name'],
      model: map['model'],
      year: (map['year'] as num?)?.toInt() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  // Convert FavoriteCar to Car
  Car toCar() {
    return Car(
      carName: name,
      manufacturer: model
          .split(' ')
          .first, // Extract manufacturer (e.g., "Toyota" from "Toyota Camry")
      price: '0', // Default price, as FavoriteCar may not have price
      year: year.toString(),
      imagePath: imageUrl,
      model: '',
      fuelType: '',
      mileage: '',
    );
  }
}
