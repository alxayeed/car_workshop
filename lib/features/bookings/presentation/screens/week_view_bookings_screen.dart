import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/booking_controller.dart';
import '../widgets/booking_card.dart';

// ignore: must_be_immutable
class WeekViewBookingsScreen extends StatefulWidget {
  final BookingsController controller = Get.find();
  DateTime selectedWeekStart =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday));

  WeekViewBookingsScreen({super.key});

  @override
  State<WeekViewBookingsScreen> createState() => _WeekViewBookingsScreenState();
}

class _WeekViewBookingsScreenState extends State<WeekViewBookingsScreen> {
  DateTime get selectedWeekEnd =>
      widget.selectedWeekStart.add(const Duration(days: 6));

  @override
  void initState() {
    super.initState();
    widget.controller.fetchBookingsForWeek(
      widget.selectedWeekStart,
      selectedWeekEnd,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: _buildWeekSelector(),
          ),
        ],
        body: _buildBookingsList(),
      ),
    );
  }

  Widget _buildWeekSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          TableCalendar(
            focusedDay: widget.selectedWeekStart,
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            calendarFormat: CalendarFormat.week,
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
              final newWeekStart = selectedDay
                  .subtract(Duration(days: selectedDay.weekday - 1))
                  .toLocal();

              if (newWeekStart != widget.selectedWeekStart) {
                setState(() {
                  widget.selectedWeekStart = newWeekStart;
                });

                widget.controller.fetchBookingsForWeek(
                  widget.selectedWeekStart.toLocal(),
                  selectedWeekEnd,
                );
              }
            },
            onPageChanged: (focusedDay) {
              final newWeekStart =
                  focusedDay.subtract(Duration(days: focusedDay.weekday - 7));

              if (newWeekStart != widget.selectedWeekStart) {
                widget.selectedWeekStart = newWeekStart;

                widget.controller.fetchBookingsForWeek(
                  widget.selectedWeekStart,
                  selectedWeekEnd,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList() {
    return RefreshIndicator(
      onRefresh: () {
        return widget.controller
            .fetchBookingsForWeek(widget.selectedWeekStart, selectedWeekEnd);
      },
      child: Obx(() {
        if (widget.controller.isLoadingWeekly.value) {
          return const CustomLoader();
        }

        if (widget.controller.errorMessage.isNotEmpty) {
          return Center(child: Text(widget.controller.errorMessage.value));
        }

        if (widget.controller.weeklyBookings.isEmpty) {
          return Center(
            child: Image.asset(
              "assets/img/no_data.jpg",
              height: 400.h,
            ),
          );
        }

        return ListView.builder(
          itemCount: widget.controller.weeklyBookings.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.bookingDetails,
                    arguments: widget.controller.weeklyBookings[index]);
              },
              child: BookingCard(
                booking: widget.controller.weeklyBookings[index],
              ),
            );
          },
        );
      }),
    );
  }
}
