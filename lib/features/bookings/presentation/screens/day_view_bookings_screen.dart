import 'package:car_workshop/core/common/widgets/custom_loader.dart';
import 'package:car_workshop/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    controller.fetchBookingsForDay(selectedDate);
  }

  void _changeDate(int delta) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: delta));
    });
    controller.fetchBookingsForDay(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return const CustomLoader();
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.dailyBookings.isEmpty) {
          return Image.asset(
            "assets/img/no_data.jpg",
            height: 400.h,
          );
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
