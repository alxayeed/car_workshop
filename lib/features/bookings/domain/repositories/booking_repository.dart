import 'package:car_workshop/features/bookings/domain/entities/booking_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class BookingRepository {
  Future<Either<Failure, void>> addBooking(BookingEntity booking);

  Future<Either<Failure, List<BookingEntity>>> fetchBookings();

  Future<Either<Failure, BookingEntity?>> getBookingById(String id);

  Future<Either<Failure, List<BookingEntity>>> getBookingsByMechanic(
      String mechanicId);
}