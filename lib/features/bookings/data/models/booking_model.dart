import 'package:car_workshop/features/bookings/domain/entities/booking_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore Timestamp

import '../../../auth/data/models/user_model.dart';
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
    required UserModel super.mechanic,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      car: CarModel.fromJson(json['car'] as Map<String, dynamic>),
      customer:
          CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      title: json['title'] as String,
      startDateTime: (json['startDateTime'] as Timestamp).toDate(),
      // Convert Firestore Timestamp to DateTime
      endDateTime: (json['endDateTime'] as Timestamp).toDate(),
      // Convert Firestore Timestamp to DateTime
      mechanic: UserModel.fromJson(json['mechanic'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car': (car as CarModel).toJson(),
      'customer': (customer as CustomerModel).toJson(),
      'title': title,
      'startDateTime': Timestamp.fromDate(startDateTime),
      // Convert DateTime to Firestore Timestamp
      'endDateTime': Timestamp.fromDate(endDateTime),
      // Convert DateTime to Firestore Timestamp
      'mechanic': (mechanic as UserModel).toJson(),
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
      mechanic: (mechanic as UserModel).toEntity(),
    );
  }
}
