import 'dart:io';

abstract class AddCarRemoteDataSource {
  Future<void> addCar({
    required String carName,
    required String manufacturer,
    required String model,
    required String year,
    required String fuelType,
    required String mileage,
    required String price,
    required File imageFile,
  });
}
