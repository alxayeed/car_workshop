import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/routes/app_routes.dart';
import '../controllers/booking_controller.dart';
import '../widgets/booking_card.dart';

// ignore: must_be_immutable
class WeekViewBookingsScreen extends StatefulWidget {
  final BookingsController controller = Get.find();
  DateTime selectedWeekStart = DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday - 1))
      .toLocal();

  WeekViewBookingsScreen({super.key});

  @override
  _WeekViewBookingsScreenState createState() => _WeekViewBookingsScreenState();
}

class _WeekViewBookingsScreenState extends State<WeekViewBookingsScreen> {
  DateTime get selectedWeekEnd =>
      widget.selectedWeekStart.add(const Duration(days: 6)).toLocal();

  void _changeWeek(int delta) {
    setState(() {
      widget.selectedWeekStart = widget.selectedWeekStart
          .add(Duration(days: 7 * delta))
          .toLocal()
          .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
    });
    widget.controller.fetchBookingsForWeek(
      widget.selectedWeekStart.subtract(const Duration(days: 1)),
      selectedWeekEnd.subtract(const Duration(days: 1)),
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
            headerStyle: const HeaderStyle(formatButtonVisible: false),
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
                widget.selectedWeekStart = selectedDay
                    .subtract(Duration(days: selectedDay.weekday - 1))
                    .toLocal()
                    .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
              });
              widget.controller.fetchBookingsForWeek(
                widget.selectedWeekStart.subtract(const Duration(days: 1)),
                selectedWeekEnd.subtract(const Duration(days: 1)),
              );
            },
            onPageChanged: (focusedDay) {
              setState(() {
                widget.selectedWeekStart = focusedDay
                    .subtract(Duration(days: focusedDay.weekday - 1))
                    .toLocal()
                    .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
              });
              widget.controller.fetchBookingsForWeek(
                widget.selectedWeekStart.subtract(const Duration(days: 1)),
                selectedWeekEnd.subtract(const Duration(days: 1)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList() {
    return RefreshIndicator(
      onRefresh: () {
        return widget.controller.loadBookings();
      },
      child: Obx(() {
        if (widget.controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (widget.controller.errorMessage.isNotEmpty) {
          return Center(child: Text(widget.controller.errorMessage.value));
        }

        if (widget.controller.bookings.isEmpty) {
          return const Center(child: Text('No bookings found.'));
        }

        return ListView.builder(
          itemCount: widget.controller.bookings.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.bookingDetails,
                    arguments: widget.controller.bookings[index]);
              },
              child: BookingCard(
                booking: widget.controller.bookings[index],
              ),
            );
          },
        );
      }),
    );
  }
}
