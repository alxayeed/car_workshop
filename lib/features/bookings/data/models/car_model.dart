import 'package:car_workshop/features/bookings/domain/entities/car_entity.dart';

class CarModel extends CarEntity {
  const CarModel({
    required super.make,
    required super.model,
    required super.year,
    required super.registrationPlate,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      registrationPlate: json['registrationPlate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'year': year,
      'registrationPlate': registrationPlate,
    };
  }

  CarEntity toEntity() {
    return CarEntity(
      make: make,
      model: model,
      year: year,
      registrationPlate: registrationPlate,
    );
  }
}
