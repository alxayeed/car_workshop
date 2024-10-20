import 'package:dartz/dartz.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/errors/failure.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class FetchBookingsUseCase {
  final BookingRepository repository;

  FetchBookingsUseCase(this.repository);

  Future<Either<Failure, List<BookingEntity>>> call(UserEntity? user) async {
    try {
      return await repository.fetchBookings();

      if (user?.role == UserRole.mechanic) {
        return await repository.getBookingsByMechanic(user?.id ?? "");
      } else {
        return await repository.fetchBookings();
      }
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
