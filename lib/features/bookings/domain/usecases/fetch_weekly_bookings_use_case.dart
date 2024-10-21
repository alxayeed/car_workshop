import 'package:car_workshop/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class FetchWeeklyBookingsUseCase {
  final BookingRepository repository;

  FetchWeeklyBookingsUseCase(this.repository);

  Future<Either<Failure, List<BookingEntity>>> call(
      DateTime fromDate, DateTime toDate) async {
    return await repository.fetchBookingsInRange(fromDate, toDate);
  }
}
