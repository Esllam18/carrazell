part of 'get_cars_cubit.dart';

abstract class GetCarsState {}

class GetCarsInitial extends GetCarsState {}

class GetCarsLoading extends GetCarsState {}

class GetCarsSuccess extends GetCarsState {
  final List<Car> cars;
  GetCarsSuccess(this.cars);
}

class GetCarsFailure extends GetCarsState {
  final String message;
  GetCarsFailure(this.message);
}
