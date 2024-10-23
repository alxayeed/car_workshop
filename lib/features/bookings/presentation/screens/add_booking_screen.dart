import 'package:car_workshop/core/constants/app_strings.dart';
import 'package:car_workshop/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/widgets.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/car_entity.dart';
import '../../domain/entities/customer_entity.dart';
import '../controllers/booking_controller.dart';

// ignore: must_be_immutable
class AddBookingScreen extends StatelessWidget {
  final BookingsController bookingsController = Get.find<BookingsController>();

  AddBookingScreen({super.key});

  final TextEditingController carMakeController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carYearController = TextEditingController();
  final TextEditingController carRegistrationPlateController =
      TextEditingController();

  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerPhoneNumberController =
      TextEditingController();
  final TextEditingController customerEmailController = TextEditingController();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController startDateTimeController = TextEditingController();
  final TextEditingController endDateTimeController = TextEditingController();

  Rx<UserEntity?> selectedMechanic = Rx<UserEntity?>(null);

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text(AppStrings.addBooking),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.carDetails,
              style: TextStyle(fontSize: 28.sp),
            ),
            CustomTextField(
              controller: carMakeController,
              hintText: AppStrings.carMake,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              controller: carModelController,
              hintText: AppStrings.carModel,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              controller: carYearController,
              hintText: AppStrings.carYear,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              controller: carRegistrationPlateController,
              hintText: AppStrings.registrationPlate,
            ),
            SizedBox(height: 20.h),
            Text(AppStrings.customerDetails, style: TextStyle(fontSize: 28.sp)),
            CustomTextField(
              controller: customerNameController,
              hintText: AppStrings.customerName,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              controller: customerPhoneNumberController,
              hintText: AppStrings.phoneNumber,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              controller: customerEmailController,
              hintText: AppStrings.email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.h),
            Text(AppStrings.bookingDetails, style: TextStyle(fontSize: 28.sp)),
            CustomTextField(
              controller: titleController,
              hintText: AppStrings.bookingTitle,
            ),
            SizedBox(height: 20.h),
            Obx(() => CustomDropdownButton<UserEntity>(
                  hint: AppStrings.selectMechanic,
                  value: selectedMechanic.value,
                  items: bookingsController.mechanics
                      .map(
                        (mechanic) => DropdownMenuItem<UserEntity>(
                          value: mechanic,
                          child: Text(mechanic.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    selectedMechanic.value = value;
                  },
                )),
            SizedBox(height: 20.h),
            CustomTextField(
              controller: startDateTimeController,
              hintText: AppStrings.startDate,
              prefixIcon: Icons.calendar_today,
              obscureText: false,
              keyboardType: TextInputType.datetime,
              readOnly: true,
              onTap: () => _selectDate(context, startDateTimeController),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              controller: endDateTimeController,
              hintText: AppStrings.endDate,
              prefixIcon: Icons.calendar_today,
              obscureText: false,
              keyboardType: TextInputType.datetime,
              readOnly: true,
              onTap: () => _selectDate(context, endDateTimeController),
            ),
            SizedBox(height: 20.h),
            Obx(() => CustomButton(
                  labelText: bookingsController.isAddingBooking.value
                      ? AppStrings.pleaseWait
                      : AppStrings.addBooking,
                  backgroundColor: bookingsController.isAddingBooking.value
                      ? Colors.grey
                      : Colors.green,
                  onPressed: () {
                    final int carYear = int.parse(carYearController.text);

                    final car = CarEntity(
                      make: carMakeController.text,
                      model: carModelController.text,
                      year: carYear,
                      registrationPlate: carRegistrationPlateController.text,
                    );

                    final customer = CustomerEntity(
                      name: customerNameController.text,
                      phoneNumber: customerPhoneNumberController.text,
                      email: customerEmailController.text,
                    );

                    final booking = BookingEntity(
                      id: '',
                      car: car,
                      customer: customer,
                      title: titleController.text,
                      startDateTime:
                          DateTime.parse(startDateTimeController.text),
                      endDateTime: DateTime.parse(endDateTimeController.text),
                      mechanic: selectedMechanic.value!,
                    );

                    bookingsController.addBooking(booking);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
