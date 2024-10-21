import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/booking_entity.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookingEntity booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd MMMM, yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(booking.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Car Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text('Make: ${booking.car.make}',
                style: const TextStyle(fontSize: 16)),
            Text('Model: ${booking.car.model}',
                style: const TextStyle(fontSize: 16)),
            Text('Year: ${booking.car.year}',
                style: const TextStyle(fontSize: 16)),
            Text('Registration Plate: ${booking.car.registrationPlate}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Customer Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text('Name: ${booking.customer.name}',
                style: const TextStyle(fontSize: 16)),
            Text('Phone: ${booking.customer.phoneNumber}',
                style: const TextStyle(fontSize: 16)),
            Text('Email: ${booking.customer.email}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Booking Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text('Title: ${booking.title}',
                style: const TextStyle(fontSize: 16)),
            Text(
              'From: ${dateFormat.format(DateTime.parse(booking.startDateTime.toString()))}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'To: ${dateFormat.format(DateTime.parse(booking.endDateTime.toString()))}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text('Assigned Mechanic',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text('Name: ${booking.mechanic.name}',
                style: const TextStyle(fontSize: 16)),
            Text('Email: ${booking.mechanic.email}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
