import 'package:car_workshop/features/bookings/data/models/customer_model.dart';
import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final String name;
  final String phoneNumber;
  final String email;

  const CustomerEntity({
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  @override
  List<Object> get props => [name, phoneNumber, email];

  CustomerModel toModel() {
    return CustomerModel(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
    );
  }
}
