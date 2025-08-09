import 'dart:io';

import 'package:carraze/features/add_car/data/addCar_remote_data_source.dart';
import 'package:carraze/features/add_car/data/addCar_reposittory.dart';

class AddCarRepositoryImpl implements AddCarRepository {
  final AddCarRemoteDataSource remoteDataSource;

  AddCarRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addCar({
    required String carName,
    required String manufacturer,
    required String model,
    required String year,
    required String fuelType,
    required String mileage,
    required String price,
    required File imageFile,
  }) {
    return remoteDataSource.addCar(
      carName: carName,
      manufacturer: manufacturer,
      model: model,
      year: year,
      fuelType: fuelType,
      mileage: mileage,
      price: price,
      imageFile: imageFile,
    );
  }
}
