import 'package:carraze/core/models/car_model.dart';
import 'package:carraze/features/home/data/get_cars_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_cars_state.dart';

class GetCarsCubit extends Cubit<GetCarsState> {
  final GetCarsRepository repository;
  List<Car> _allCars = [];

  GetCarsCubit(this.repository) : super(GetCarsInitial());

  Future<void> fetchCars() async {
    emit(GetCarsLoading());
    try {
      final cars = await repository.getCars();
      _allCars = cars;
      emit(GetCarsSuccess(cars));
    } catch (e) {
      emit(GetCarsFailure(e.toString()));
    }
  }

  void filterCarsByCategory(String? category) {
    if (category == null || category == "All") {
      emit(GetCarsSuccess(_allCars));
    } else {
      final filteredCars = _allCars
          .where((car) => car.manufacturer == category)
          .toList();
      emit(GetCarsSuccess(filteredCars));
    }
  }
}
