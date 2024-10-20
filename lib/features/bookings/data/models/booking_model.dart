import 'package:car_workshop/features/bookings/domain/entities/booking_entity.dart';

import 'car_model.dart';
import 'customer_model.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required CarModel super.car,
    required CustomerModel super.customer,
    required super.title,
    required super.startDateTime,
    required super.endDateTime,
    required super.mechanicId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      car: CarModel.fromJson(json['car'] as Map<String, dynamic>),
      customer:
          CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      title: json['title'] as String,
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endDateTime: DateTime.parse(json['endDateTime'] as String),
      mechanicId: json['mechanicId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car': (car as CarModel).toJson(),
      'customer': (customer as CustomerModel).toJson(),
      'title': title,
      'startDateTime': startDateTime.toIso8601String(),
      'endDateTime': endDateTime.toIso8601String(),
      'mechanicId': mechanicId,
    };
  }

  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      car: (car as CarModel).toEntity(),
      customer: (customer as CustomerModel).toEntity(),
      title: title,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      mechanicId: mechanicId,
    );
  }
}
