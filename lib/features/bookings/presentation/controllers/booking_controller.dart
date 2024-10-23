import 'package:car_workshop/core/routes/app_routes.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/services.dart';
import '../../../../core/usecase/no_params.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/usecases/get_all_mechanics_use_case.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/add_booking_use_case.dart';
import '../../domain/usecases/delete_booking_use_case.dart';
import '../../domain/usecases/fetch_daily_bookings_use_case.dart';
import '../../domain/usecases/fetch_monthly_bookings_use_case.dart';
import '../../domain/usecases/fetch_weekly_bookings_use_case.dart';

class BookingsController extends GetxController {
  final FetchDailyBookingsUseCase fetchDailyBookingsUseCase;
  final FetchWeeklyBookingsUseCase fetchWeeklyBookingsUseCase;
  final FetchMonthlyBookingsUseCase fetchMonthlyBookingsUseCase;
  final AddBookingUseCase addBookingUseCase;
  final GetAllMechanicsUseCase getAllMechanicsUseCase;
  final DeleteBookingUseCase deleteBookingUseCase;

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
  RxBool isDeletingBooking = false.obs;

  BookingsController(
    this.fetchDailyBookingsUseCase,
    this.fetchWeeklyBookingsUseCase,
    this.fetchMonthlyBookingsUseCase,
    this.addBookingUseCase,
    this.getAllMechanicsUseCase,
    this.deleteBookingUseCase,
  );

  @override
  void onInit() {
    super.onInit();
    fetchMechanics();
  }

  Future<void> fetchMechanics() async {
    try {
      await getAllMechanicsUseCase(NoParams()).then(
        (value) => saveMechanicsToCache(),
      );
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {}
  }

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
    DateTime modifiedFromDate = fromDate.toLocal().copyWith(
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );

    DateTime modifiedToDate = toDate.toLocal().copyWith(
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );

    final Either<Failure, List<BookingEntity>> bookingsResult =
        await fetchWeeklyBookingsUseCase(modifiedFromDate, modifiedToDate);

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
        SnackbarService.showErrorMessage(failure.message);
      },
      (_) {
        dailyBookings.add(booking);
        SnackbarService.showSuccessMessage(AppStrings.bookingAdded);
        Future.delayed(const Duration(milliseconds: 300), () {
          navigateToBookingsList();
        });
      },
    );

    isAddingBooking.value = false;
  }

  Future<void> deleteBooking(String bookingId) async {
    Get.dialog(
      AlertDialog(
        title: const Text(AppStrings.warning),
        content: const Text(AppStrings.bookingDeleteConfirmationMessage),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              isDeletingBooking.value = true;
              final Either<Failure, void> result =
                  await deleteBookingUseCase(bookingId);

              result.fold(
                (failure) {
                  errorMessage.value = failure.toString();
                  SnackbarService.showErrorMessage(failure.message);
                },
                (_) {
                  dailyBookings
                      .removeWhere((booking) => booking.id == bookingId);
                  SnackbarService.showSuccessMessage(AppStrings.bookingDeleted);
                  navigateToBookingsList();
                },
              );

              isDeletingBooking.value = false;
            },
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
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
    Get.offAllNamed(AppRoutes.bookings);
  }
}
