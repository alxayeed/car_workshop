import 'package:car_workshop/core/errors/failure.dart';
import 'package:car_workshop/features/bookings/data/datasources/booking_remote_data_source.dart';
import 'package:car_workshop/features/bookings/data/models/booking_model.dart';
import 'package:car_workshop/features/bookings/domain/entities/booking_entity.dart';
import 'package:car_workshop/features/bookings/domain/repositories/booking_repository.dart';
import 'package:dartz/dartz.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> addBooking(BookingEntity booking) async {
    try {
      final bookingModel = BookingModel(
        id: booking.id,
        car: booking.car.toModel(),
        customer: booking.customer.toModel(),
        title: booking.title,
        startDateTime: booking.startDateTime,
        endDateTime: booking.endDateTime,
        mechanic: booking.mechanic.toModel(),
      );
      await remoteDataSource.addBooking(bookingModel);
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> fetchBookings() async {
    final result = await remoteDataSource.fetchBookings();
    return result.map((bookingModels) =>
        bookingModels.map((model) => model.toEntity()).toList());
  }

  @override
  Future<Either<Failure, BookingEntity?>> getBookingById(String id) async {
    final result = await remoteDataSource.getBookingById(id);
    return result.map((bookingModel) => bookingModel?.toEntity());
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getBookingsByMechanic(
      String mechanicId) async {
    final result = await remoteDataSource.getBookingsByMechanic(mechanicId);
    return result.map((bookingModels) =>
        bookingModels.map((model) => model.toEntity()).toList());
  }
}
