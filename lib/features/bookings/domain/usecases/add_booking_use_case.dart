import 'package:car_workshop/core/errors/failure.dart';
import 'package:car_workshop/features/bookings/domain/entities/booking_entity.dart';
import 'package:car_workshop/features/bookings/domain/repositories/booking_repository.dart';
import 'package:dartz/dartz.dart';

class AddBookingUseCase {
  final BookingRepository bookingRepository;

  AddBookingUseCase(this.bookingRepository);

  Future<Either<Failure, void>> call(BookingEntity booking) {
    return bookingRepository.addBooking(booking);
  }
}
