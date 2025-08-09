class Car {
  final String carName;
  final String manufacturer;
  final String model;
  final String year;
  final String fuelType;
  final String mileage;
  final String price;
  final String imagePath;

  Car({
    required this.carName,
    required this.manufacturer,
    required this.model,
    required this.year,
    required this.fuelType,
    required this.mileage,
    required this.price,
    required this.imagePath,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    carName: json['carName'],
    manufacturer: json['manufacturer'],
    model: json['model'],
    year: json['year'],
    fuelType: json['fuelType'],
    mileage: json['mileage'],
    price: json['price'],
    imagePath: json['imagePath'],
  );

  Map<String, dynamic> toJson() {
    return {
      'carName': carName,
      'manufacturer': manufacturer,
      'model': model,
      'year': year,
      'fuelType': fuelType,
      'mileage': mileage,
      'price': price,
      'imagePath': imagePath,
    };
  }
}
