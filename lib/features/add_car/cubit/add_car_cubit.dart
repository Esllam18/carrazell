import 'dart:io';

import 'package:carraze/features/add_car/data/addCar_reposittory.dart';
import 'package:carraze/features/add_car/cubit/add_car_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCar extends Cubit<AddCarState> {
  final AddCarRepository addCarRepository;

  AddCar(this.addCarRepository) : super(AddCarInitial());

  Future<void> addCar({
    required String carName,
    required String manufacturer,
    required String model,
    required String year,
    required String fuelType,
    required String mileage,
    required String price,
    required File imageFile,
  }) async {
    emit(AddCarLoading());
    try {
      await addCarRepository.addCar(
        carName: carName,
        manufacturer: manufacturer,
        model: model,
        year: year,
        fuelType: fuelType,
        mileage: mileage,
        price: price,
        imageFile: imageFile,
      );
      emit(AddCarSuccess());
    } catch (e) {
      emit(AddCarFailure(e.toString()));
    }
  }
}
