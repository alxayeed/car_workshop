import 'package:dartz/dartz.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/no_params.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/usecases/get_all_mechanics_use_case.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class FetchBookingsUseCase {
  final BookingRepository repository;
  final GetAllMechanicsUseCase getAllMechanicsUseCase;

  FetchBookingsUseCase(this.repository, this.getAllMechanicsUseCase);

  Future<Either<Failure, List<BookingEntity>>> call(UserEntity? user) async {
    try {
      // Fetch and store mechanics
      await getAllMechanicsUseCase(NoParams());
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
