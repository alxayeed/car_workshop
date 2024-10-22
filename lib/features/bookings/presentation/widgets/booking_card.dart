import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/widgets/widgets.dart';
import '../../domain/entities/booking_entity.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd MMMM, yyyy');

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
      elevation: 2,
      color: Colors.teal.shade50,
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.title,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            ShowInfoWidget(
              title: 'Customer: ',
              value: booking.customer.name,
              icon: Icons.person,
            ),
            ShowInfoWidget(
              title: 'Mechanic: ',
              value: booking.mechanic.name,
              icon: Icons.build,
            ),
            ShowInfoWidget(
              title: 'From: ',
              value: dateFormat
                  .format(DateTime.parse(booking.startDateTime.toString())),
              icon: Icons.date_range,
            ),
          ],
        ),
      ),
    );
  }
}
