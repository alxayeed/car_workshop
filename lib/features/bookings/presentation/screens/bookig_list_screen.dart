import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/booking_entity.dart';
import '../controllers/booking_controller.dart';
import '../screens/add_booking_screen.dart';
import '../widgets/booking_card.dart';

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
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('Bookings'),
      // ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.loadBookings();
        },
        child: Obx(() {
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
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.bookingDetails, arguments: booking);
                },
                child: BookingCard(booking: booking),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddBookingScreen());
        },
        tooltip: 'Add Booking',
        child: const Icon(Icons.add),
      ),
    );
  }
}
