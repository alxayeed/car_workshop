import 'package:car_workshop/features/bookings/domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  const CustomerModel({
    required super.name,
    required super.phoneNumber,
    required super.email,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  CustomerEntity toEntity() {
    return CustomerEntity(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
    );
  }
}
