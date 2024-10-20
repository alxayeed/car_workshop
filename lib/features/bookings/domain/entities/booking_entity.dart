import 'package:car_workshop/features/bookings/data/models/booking_model.dart';
import 'package:equatable/equatable.dart';

import 'car_entity.dart';
import 'customer_entity.dart';

class BookingEntity extends Equatable {
  final String id;
  final CarEntity car;
  final CustomerEntity customer;
  final String title;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String mechanicId;

  const BookingEntity({
    required this.id,
    required this.car,
    required this.customer,
    required this.title,
    required this.startDateTime,
    required this.endDateTime,
    required this.mechanicId,
  });

  @override
  List<Object> get props => [
        id,
        car,
        customer,
        title,
        startDateTime,
        endDateTime,
        mechanicId,
      ];

  BookingModel toModel() {
    return BookingModel(
      id: id,
      car: car.toModel(),
      customer: customer.toModel(),
      title: title,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      mechanicId: mechanicId,
    );
  }
}
