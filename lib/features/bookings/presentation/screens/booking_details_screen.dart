import 'package:car_workshop/features/bookings/presentation/controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/style/app_colors.dart';
import '../../domain/entities/booking_entity.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookingEntity booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd MMMM, yyyy');
    BookingsController bookingsController = Get.find();
    final AuthService authService = Get.find<AuthService>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(booking.title),
        actions: [
          !authService.isMechanic
              ? IconButton(
                  onPressed: () {
                    bookingsController.deleteBooking(booking.id);
                  },
                  icon: Icon(
                    size: 36.sp,
                    Icons.delete,
                    color: AppColors.errorBackground,
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSection(
                title: 'Car Details',
                children: [
                  ShowInfoWidget(
                    title: 'Make: ',
                    value: booking.car.make,
                    icon: Icons.directions_car,
                  ),
                  ShowInfoWidget(
                    title: 'Model: ',
                    value: booking.car.model,
                    icon: Icons.car_repair,
                  ),
                  ShowInfoWidget(
                    title: 'Year: ',
                    value: booking.car.year.toString(),
                    icon: Icons.calendar_today,
                  ),
                  ShowInfoWidget(
                    title: 'Registration Plate: ',
                    value: booking.car.registrationPlate,
                    icon: Icons.confirmation_number,
                  ),
                ],
              ),
              buildDivider(),
              buildSection(
                title: 'Customer Details',
                children: [
                  ShowInfoWidget(
                    title: 'Name: ',
                    value: booking.customer.name,
                    icon: Icons.person,
                  ),
                  ShowInfoWidget(
                    title: 'Phone: ',
                    value: booking.customer.phoneNumber,
                    icon: Icons.phone,
                  ),
                  ShowInfoWidget(
                    title: 'Email: ',
                    value: booking.customer.email,
                    icon: Icons.email,
                  ),
                ],
              ),
              buildDivider(),
              buildSection(
                title: 'Booking Details',
                children: [
                  ShowInfoWidget(
                    title: 'Title: ',
                    value: booking.title,
                    icon: Icons.title,
                  ),
                  ShowInfoWidget(
                    title: 'From: ',
                    value: dateFormat.format(
                        DateTime.parse(booking.startDateTime.toString())),
                    icon: Icons.date_range,
                  ),
                  ShowInfoWidget(
                    title: 'To: ',
                    value: dateFormat
                        .format(DateTime.parse(booking.endDateTime.toString())),
                    icon: Icons.date_range,
                  ),
                ],
              ),
              buildDivider(),
              buildSection(
                title: 'Assigned Mechanic',
                children: [
                  ShowInfoWidget(
                    title: 'Name: ',
                    value: booking.mechanic.name,
                    icon: Icons.person,
                  ),
                  ShowInfoWidget(
                    title: 'Email: ',
                    value: booking.mechanic.email,
                    icon: Icons.email,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection({required String title, required List<Widget> children}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          ...children,
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Divider(
      height: 40.h,
      thickness: 1,
      color: Colors.grey.shade400,
    );
  }
}
