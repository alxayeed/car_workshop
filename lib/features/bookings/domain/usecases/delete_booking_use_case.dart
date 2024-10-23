import 'package:car_workshop/core/errors/failure.dart';
import 'package:car_workshop/features/bookings/domain/repositories/booking_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteBookingUseCase {
  final BookingRepository repository;

  DeleteBookingUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteBooking(id);
  }
}
