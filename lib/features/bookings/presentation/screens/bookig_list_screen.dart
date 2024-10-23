import 'package:car_workshop/core/constants/app_strings.dart';
import 'package:car_workshop/core/routes/app_routes.dart';
import 'package:car_workshop/core/style/app_colors.dart';
import 'package:car_workshop/features/bookings/presentation/screens/week_view_bookings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/booking_controller.dart';
import '../screens/add_booking_screen.dart';
import '../screens/day_view_bookings_screen.dart';
import '../screens/month_view_bookings_screen.dart';

class BookingsListScreen extends StatefulWidget {
  final BookingsController controller = Get.put(
    BookingsController(
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find()),
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
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            AppStrings.appTitle,
            style: TextStyle(fontSize: 34.sp),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.person,
                size: 36.sp,
              ),
              onPressed: () {
                Get.toNamed(AppRoutes.profile);
              },
            ),
          ],
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  "Today",
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
              Tab(
                child: Text(
                  "This Week",
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
              Tab(
                child: Text(
                  "This Month",
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
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
            MonthViewBookingsScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            Get.to(() => AddBookingScreen());
          },
          tooltip: 'Add Booking',
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
