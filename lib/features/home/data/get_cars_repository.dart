import 'package:carraze/core/models/car_model.dart';

abstract class GetCarsRepository {
  Future<List<Car>> getCars();
}
