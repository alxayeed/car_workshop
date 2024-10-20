import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/style/app_colors.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/add_booking_use_case.dart';
import '../../domain/usecases/fetch_bookings_use_case.dart';

class BookingsController extends GetxController {
  final FetchBookingsUseCase fetchBookingsUseCase;
  final AddBookingUseCase addBookingUseCase;

  RxList<BookingEntity> bookings = <BookingEntity>[].obs;
  RxList<UserEntity> mechanics = <UserEntity>[].obs;
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isAddingBooking = false.obs;

  BookingsController(this.fetchBookingsUseCase, this.addBookingUseCase);

  @override
  void onInit() {
    super.onInit();
    loadBookings();
  }

  Future<void> loadBookings() async {
    isLoading.value = true;

    final box = GetStorage();
    final List<dynamic> storedMechanics = box.read('mechanics') ?? [];

    final List<UserEntity> mechanicEntities = storedMechanics
        .map((mechanicJson) => UserModel.fromJson(mechanicJson).toEntity())
        .toList();

    mechanics.addAll(mechanicEntities);

    final Either<Failure, List<BookingEntity>> bookingsResult =
        await fetchBookingsUseCase(null);

    bookingsResult.fold(
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

  Future<void> addBooking(BookingEntity booking) async {
    isAddingBooking.value = true;
    final Either<Failure, void> result = await addBookingUseCase(booking);

    result.fold(
      (failure) {
        errorMessage.value = failure.toString();
        Get.snackbar(
          AppStrings.error,
          errorMessage.value,
          backgroundColor: AppColors.errorBackground,
        );
      },
      (_) {
        bookings.add(booking);
        Get.snackbar(
          AppStrings.success,
          'Booking added.',
          backgroundColor: AppColors.successBackground,
          duration: const Duration(seconds: 5),
        );
        navigateToBookingsList();
      },
    );

    isAddingBooking.value = false;
  }

  void navigateToBookingsList() {
    Get.offAllNamed('/bookings');
  }
}
