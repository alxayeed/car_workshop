import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failure.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/fetch_bookings_use_case.dart';

class BookingsController extends GetxController {
  final FetchBookingsUseCase fetchBookingsUseCase;

  RxList<BookingEntity> bookings = <BookingEntity>[].obs;
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;

  BookingsController(this.fetchBookingsUseCase);

  @override
  void onInit() {
    super.onInit();
    final user = Get.arguments as UserEntity;
    loadBookings(user);
  }

  Future<void> loadBookings(UserEntity user) async {
    isLoading.value = true;
    final Either<Failure, List<BookingEntity>> result =
        await fetchBookingsUseCase(user);
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
}
