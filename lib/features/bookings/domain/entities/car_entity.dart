import 'package:car_workshop/features/bookings/data/models/car_model.dart';
import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
  final String make;
  final String model;
  final int year;
  final String registrationPlate;

  const CarEntity({
    required this.make,
    required this.model,
    required this.year,
    required this.registrationPlate,
  });

  @override
  List<Object> get props => [make, model, year, registrationPlate];

  CarModel toModel() {
    return CarModel(
      make: make,
      model: model,
      year: year,
      registrationPlate: registrationPlate,
    );
  }
}
