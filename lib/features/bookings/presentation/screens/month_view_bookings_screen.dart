import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/booking_controller.dart';
import '../widgets/booking_card.dart';

// ignore: must_be_immutable
class MonthViewBookingsScreen extends StatefulWidget {
  final BookingsController controller = Get.find();
  DateTime selectedMonthStart = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  ).toLocal();

  MonthViewBookingsScreen({super.key});

  @override
  State<MonthViewBookingsScreen> createState() =>
      _MonthViewBookingsScreenState();
}

class _MonthViewBookingsScreenState extends State<MonthViewBookingsScreen> {
  DateTime get selectedMonthEnd {
    return DateTime(
      widget.selectedMonthStart.year,
      widget.selectedMonthStart.month + 1,
      0,
    ).toLocal();
  }

  @override
  void initState() {
    super.initState();
    widget.controller.fetchBookingsForMonth(
      DateTime(
        widget.selectedMonthStart.year,
        widget.selectedMonthStart.month,
        1,
      ),
      selectedMonthEnd,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: _buildMonthSelector(),
          ),
        ],
        body: _buildBookingsList(),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TableCalendar(
        focusedDay: widget.selectedMonthStart,
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        calendarFormat: CalendarFormat.month,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.teal,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            widget.selectedMonthStart = DateTime(
              focusedDay.year,
              focusedDay.month,
            ).toLocal();
          });
          widget.controller.fetchBookingsForMonth(
            DateTime(
              widget.selectedMonthStart.year,
              widget.selectedMonthStart.month,
              1,
            ),
            selectedMonthEnd,
          );
        },
        onPageChanged: (focusedDay) {
          setState(() {
            widget.selectedMonthStart = DateTime(
              focusedDay.year,
              focusedDay.month,
            ).toLocal();
          });
          widget.controller.fetchBookingsForMonth(
            DateTime(
              widget.selectedMonthStart.year,
              widget.selectedMonthStart.month,
              1,
            ),
            selectedMonthEnd,
          );
        },
      ),
    );
  }

  Widget _buildBookingsList() {
    return RefreshIndicator(
      onRefresh: () {
        return widget.controller
            .fetchBookingsForMonth(widget.selectedMonthStart, selectedMonthEnd);
      },
      child: Obx(() {
        if (widget.controller.isLoadingMonthly.value) {
          return const CustomLoader();
        }

        if (widget.controller.errorMessage.isNotEmpty) {
          return Center(child: Text(widget.controller.errorMessage.value));
        }

        if (widget.controller.monthlyBookings.isEmpty) {
          return Center(
            child: Image.asset(
              "assets/img/no_data.jpg",
              height: 400.h,
            ),
          );
        }

        return ListView.builder(
          itemCount: widget.controller.monthlyBookings.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.bookingDetails,
                    arguments: widget.controller.monthlyBookings[index]);
              },
              child: BookingCard(
                booking: widget.controller.monthlyBookings[index],
              ),
            );
          },
        );
      }),
    );
  }
}
