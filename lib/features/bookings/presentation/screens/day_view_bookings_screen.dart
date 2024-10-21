import 'package:car_workshop/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/booking_controller.dart';
import '../widgets/booking_card.dart';

class DayViewBookingsScreen extends StatefulWidget {
  const DayViewBookingsScreen({super.key});

  @override
  State<DayViewBookingsScreen> createState() => _DayViewBookingsScreenState();
}

class _DayViewBookingsScreenState extends State<DayViewBookingsScreen> {
  final BookingsController controller = Get.find();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    controller
        .fetchBookingsForDay(selectedDate); // Fetch daily bookings initially
  }

  void _changeDate(int delta) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: delta));
    });
    controller.fetchBookingsForDay(
        selectedDate); // Fetch daily bookings for the new selected date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Daily Bookings'),
      // ),
      body: Column(
        children: [
          _buildDateSelector(),
          Expanded(child: _buildBookingsList()),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: () => _changeDate(-1),
          ),
          Text(
            DateFormat('d MMMM, y').format(selectedDate),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: () => _changeDate(1),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList() {
    return RefreshIndicator(
      onRefresh: () {
        return controller.fetchBookingsForDay(selectedDate);
      },
      child: Obx(() {
        if (controller.isLoadingDaily.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.dailyBookings.isEmpty) {
          return const Center(child: Text('No bookings found for this day.'));
        }

        return ListView.builder(
          itemCount: controller.dailyBookings.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.bookingDetails,
                    arguments: controller.dailyBookings[index]);
              },
              child: BookingCard(
                booking: controller.dailyBookings[index],
              ),
            );
          },
        );
      }),
    );
  }
}
