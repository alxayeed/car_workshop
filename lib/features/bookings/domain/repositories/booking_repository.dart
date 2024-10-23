import 'package:car_workshop/features/bookings/domain/entities/booking_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class BookingRepository {
  Future<Either<Failure, void>> addBooking(BookingEntity booking);

  Future<Either<Failure, List<BookingEntity>>> fetchBookings();

  Future<Either<Failure, BookingEntity?>> getBookingById(String id);

  Future<Either<Failure, List<BookingEntity>>> getBookingsByMechanic(
      String mechanicId);

  Future<Either<Failure, List<BookingEntity>>> fetchBookingsForDay(
      DateTime date);

  Future<Either<Failure, List<BookingEntity>>> fetchBookingsInRange(
      DateTime fromDate, DateTime toDate);

  Future<Either<Failure, void>> deleteBooking(String id);
}
