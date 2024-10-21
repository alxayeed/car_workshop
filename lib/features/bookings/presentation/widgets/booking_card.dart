import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/booking_entity.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingCard({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd MMMM, yyyy');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Customer: ${booking.customer.name}',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              'Mechanic: ${booking.mechanic.name}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4.0),
            Text(
              'From: ${dateFormat.format(DateTime.parse(booking.startDateTime.toString()))}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
