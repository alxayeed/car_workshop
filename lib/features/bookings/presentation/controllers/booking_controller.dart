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
import '../../domain/usecases/fetch_daily_bookings_use_case.dart';
import '../../domain/usecases/fetch_monthly_bookings_use_case.dart';
import '../../domain/usecases/fetch_weekly_bookings_use_case.dart';

class BookingsController extends GetxController {
  final FetchDailyBookingsUseCase fetchDailyBookingsUseCase;
  final FetchWeeklyBookingsUseCase fetchWeeklyBookingsUseCase;
  final FetchMonthlyBookingsUseCase fetchMonthlyBookingsUseCase;
  final AddBookingUseCase addBookingUseCase;

  // Separate lists for daily, weekly, and monthly bookings
  RxList<BookingEntity> dailyBookings = <BookingEntity>[].obs;
  RxList<BookingEntity> weeklyBookings = <BookingEntity>[].obs;
  RxList<BookingEntity> monthlyBookings = <BookingEntity>[].obs;

  RxList<UserEntity> mechanics = <UserEntity>[].obs;
  RxString errorMessage = ''.obs;

  // Separate loading flags for daily, weekly, and monthly
  RxBool isLoadingDaily = false.obs;
  RxBool isLoadingWeekly = false.obs;
  RxBool isLoadingMonthly = false.obs;
  RxBool isAddingBooking = false.obs;

  BookingsController(
    this.fetchDailyBookingsUseCase,
    this.fetchWeeklyBookingsUseCase,
    this.fetchMonthlyBookingsUseCase,
    this.addBookingUseCase,
  );

  Future<void> fetchBookingsForDay(DateTime selectedDate) async {
    isLoadingDaily.value = true;

    final Either<Failure, List<BookingEntity>> bookingsResult =
        await fetchDailyBookingsUseCase(selectedDate);

    bookingsResult.fold(
      (failure) {
        errorMessage.value = failure.toString();
        dailyBookings.clear();
      },
      (fetchedBookings) {
        dailyBookings.assignAll(fetchedBookings);
      },
    );

    isLoadingDaily.value = false;
  }

  Future<void> fetchBookingsForWeek(DateTime fromDate, DateTime toDate) async {
    isLoadingWeekly.value = true;

    final Either<Failure, List<BookingEntity>> bookingsResult =
        await fetchWeeklyBookingsUseCase(fromDate, toDate);

    bookingsResult.fold(
      (failure) {
        errorMessage.value = failure.toString();
        weeklyBookings.clear();
      },
      (fetchedBookings) {
        weeklyBookings.assignAll(fetchedBookings);
      },
    );

    isLoadingWeekly.value = false;
  }

  Future<void> fetchBookingsForMonth(
      DateTime startDate, DateTime endDate) async {
    isLoadingMonthly.value = true;

    final Either<Failure, List<BookingEntity>> bookingsResult =
        await fetchMonthlyBookingsUseCase(startDate, endDate);

    bookingsResult.fold(
      (failure) {
        errorMessage.value = failure.toString();
        monthlyBookings.clear();
      },
      (fetchedBookings) {
        monthlyBookings.assignAll(fetchedBookings);
      },
    );

    isLoadingMonthly.value = false;
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
        dailyBookings.add(booking); // Assuming daily booking update
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

  void saveMechanicsToCache() {
    final box = GetStorage();
    final List<dynamic> storedMechanics = box.read('mechanics') ?? [];

    final List<UserEntity> mechanicEntities = storedMechanics
        .map((mechanicJson) => UserModel.fromJson(mechanicJson).toEntity())
        .toList();

    mechanics.clear();
    mechanics.addAll(mechanicEntities);
  }

  void navigateToBookingsList() {
    Get.offAllNamed('/bookings');
  }
}
