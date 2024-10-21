import 'package:car_workshop/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class FetchDailyBookingsUseCase {
  final BookingRepository repository;

  FetchDailyBookingsUseCase(this.repository);

  Future<Either<Failure, List<BookingEntity>>> call(DateTime date) async {
    return await repository.fetchBookingsForDay(date);
  }
}
