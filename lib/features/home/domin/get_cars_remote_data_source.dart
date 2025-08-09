import 'package:carraze/core/models/car_model.dart';

abstract class GetCarsRemoteDataSource {
  Future<List<Car>> getCarList();
}
