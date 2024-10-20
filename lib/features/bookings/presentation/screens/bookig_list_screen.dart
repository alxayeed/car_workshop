import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/booking_entity.dart';
import '../controllers/booking_controller.dart';

class BookingsListScreen extends StatelessWidget {
  final BookingsController controller = Get.put(
    BookingsController(
      Get.find(),
      Get.find(),
    ),
  );

  BookingsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.bookings.isEmpty) {
          return const Center(child: Text('No bookings found.'));
        }

        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            BookingEntity booking = controller.bookings[index];
            return ListTile(
              title: Text(booking.title),
              subtitle: Text(
                  'Customer: ${booking.customer.name}\nMechanic ID: ${booking.mechanicId}'),
              onTap: () {
                // Navigate to booking details screen if needed
              },
            );
          },
        );
      }),
    );
  }
}
