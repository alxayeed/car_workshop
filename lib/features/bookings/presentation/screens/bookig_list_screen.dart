import 'package:car_workshop/features/bookings/presentation/screens/week_view_bookings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/booking_controller.dart';
import '../screens/add_booking_screen.dart';
import '../screens/day_view_bookings_screen.dart';
import 'month_view_bookings_screen.dart';

class BookingsListScreen extends StatefulWidget {
  final BookingsController controller = Get.put(
    BookingsController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ),
  );

  BookingsListScreen({super.key});

  @override
  State<BookingsListScreen> createState() => _BookingsListScreenState();
}

class _BookingsListScreenState extends State<BookingsListScreen> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Bookings'),
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(8),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(text: 'Today'),
              Tab(text: 'This Week'),
              Tab(text: 'This Month'),
            ],
            onTap: (index) {
              setState(() {
                currentTabIndex = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            const DayViewBookingsScreen(),
            WeekViewBookingsScreen(),
            // Container(),
            MonthViewBookingsScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddBookingScreen());
          },
          tooltip: 'Add Booking',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
