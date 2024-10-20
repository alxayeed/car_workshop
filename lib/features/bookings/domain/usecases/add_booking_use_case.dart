import 'package:car_workshop/core/errors/failure.dart';
import 'package:car_workshop/features/bookings/domain/entities/booking_entity.dart';
import 'package:car_workshop/features/bookings/domain/repositories/booking_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class AddBookingUseCase {
  final BookingRepository bookingRepository;

  AddBookingUseCase(this.bookingRepository);

  Future<Either<Failure, void>> call(BookingEntity booking) async {
    var uuid = const Uuid();
    String bookingId = uuid.v4();

    final newBooking = booking.copyWith(id: bookingId);

    return await bookingRepository.addBooking(newBooking);
  }
}
