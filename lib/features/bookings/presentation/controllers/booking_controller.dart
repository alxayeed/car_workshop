import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/add_booking_use_case.dart';
import '../../domain/usecases/fetch_bookings_use_case.dart';

class BookingsController extends GetxController {
  final FetchBookingsUseCase fetchBookingsUseCase;
  final AddBookingUseCase addBookingUseCase;

  RxList<BookingEntity> bookings = <BookingEntity>[].obs;
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isAddingBooking = false.obs;

  BookingsController(this.fetchBookingsUseCase, this.addBookingUseCase);

  @override
  void onInit() {
    super.onInit();
    loadBookings(); // Remove user entity and just load bookings
  }

  // Fetch bookings (no user entity needed)
  Future<void> loadBookings() async {
    isLoading.value = true;
    final Either<Failure, List<BookingEntity>> result =
        await fetchBookingsUseCase(null);
    result.fold(
      (failure) {
        errorMessage.value = failure.toString();
        bookings.clear();
      },
      (fetchedBookings) {
        bookings.assignAll(fetchedBookings);
      },
    );
    isLoading.value = false;
  }

  // Add a booking
  Future<void> addBooking(BookingEntity booking) async {
    isAddingBooking.value = true;
    final Either<Failure, void> result = await addBookingUseCase(booking);
    result.fold(
      (failure) {
        errorMessage.value = failure.toString();
      },
      (_) {
        // Successfully added, reload bookings or add to the list locally
        bookings.add(booking);
      },
    );
    isAddingBooking.value = false;
  }
}
