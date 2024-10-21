import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<Either<Failure, void>> addBooking(BookingModel bookingModel);

  Future<Either<Failure, List<BookingModel>>> fetchBookings();

  Future<Either<Failure, BookingModel?>> getBookingById(String id);

  Future<Either<Failure, List<BookingModel>>> getBookingsByMechanic(
      String mechanicId);

  Future<Either<Failure, List<BookingModel>>> getBookingsByDate(DateTime date);

  Future<Either<Failure, List<BookingModel>>> getBookingsInRange(
      DateTime fromDate, DateTime toDate);
}
