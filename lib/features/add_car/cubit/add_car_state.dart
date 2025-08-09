// features/add_car/logic/cubit/add_car_state.dart

import 'package:equatable/equatable.dart';

abstract class AddCarState extends Equatable {
  const AddCarState();

  @override
  List<Object?> get props => [];
}

class AddCarInitial extends AddCarState {}

class AddCarLoading extends AddCarState {}

class AddCarSuccess extends AddCarState {}

class AddCarFailure extends AddCarState {
  final String errorMessage;

  const AddCarFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
