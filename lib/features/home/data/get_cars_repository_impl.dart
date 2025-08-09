import 'package:carraze/core/models/car_model.dart';
import 'package:carraze/features/home/data/get_cars_repository.dart';
import 'package:carraze/features/home/domin/get_cars_remote_data_source.dart';

class GetCarsRepositoryImpl implements GetCarsRepository {
  final GetCarsRemoteDataSource getCarRemoteDataSource;
  GetCarsRepositoryImpl(this.getCarRemoteDataSource);

  @override
  Future<List<Car>> getCars() {
    return getCarRemoteDataSource.getCarList();
  }
}
