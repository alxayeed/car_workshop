import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/car_entity.dart';
import '../../domain/entities/customer_entity.dart';
import '../controllers/booking_controller.dart';

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

  // Helper function to show a date picker and format the date
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0]; // Format the date
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Booking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Car Details', style: TextStyle(fontSize: 18)),
            TextField(
              controller: carMakeController,
              decoration: const InputDecoration(labelText: 'Car Make'),
            ),
            TextField(
              controller: carModelController,
              decoration: const InputDecoration(labelText: 'Car Model'),
            ),
            TextField(
              controller: carYearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Car Year'),
            ),
            TextField(
              controller: carRegistrationPlateController,
              decoration:
                  const InputDecoration(labelText: 'Registration Plate'),
            ),
            const SizedBox(height: 20),
            const Text('Customer Details', style: TextStyle(fontSize: 18)),
            TextField(
              controller: customerNameController,
              decoration: const InputDecoration(labelText: 'Customer Name'),
            ),
            TextField(
              controller: customerPhoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: customerEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            const Text('Booking Details', style: TextStyle(fontSize: 18)),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Booking Title'),
            ),
            // Start Date Picker
            TextField(
              controller: startDateTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Start Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _selectDate(context, startDateTimeController),
            ),
            // End Date Picker
            TextField(
              controller: endDateTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'End Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _selectDate(context, endDateTimeController),
            ),
            const SizedBox(height: 20),
            Obx(() => bookingsController.isAddingBooking.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
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
                        mechanicId: "",
                      );

                      bookingsController.addBooking(booking);
                    },
                    child: const Text('Add Booking'),
                  )),
          ],
        ),
      ),
    );
  }
}
