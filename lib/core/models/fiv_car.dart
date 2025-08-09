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
      year: map['year'],
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
