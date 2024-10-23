import 'package:car_workshop/features/bookings/data/datasources/booking_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/auth_service.dart';
import '../models/booking_model.dart';

class FirebaseBookingDataSource implements BookingRemoteDataSource {
  final FirebaseFirestore fireStore;
  final AuthService authService = Get.find<AuthService>();

  FirebaseBookingDataSource(this.fireStore);

  @override
  Future<Either<Failure, void>> addBooking(BookingModel booking) async {
    try {
      await fireStore.collection('bookings').add(booking.toJson());
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingModel>>> fetchBookings() async {
    try {
      final snapshot = await fireStore.collection('bookings').get();
      final bookings = snapshot.docs.map((doc) {
        return BookingModel.fromJson(doc.data());
      }).toList();
      return Right(bookings);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, BookingModel?>> getBookingById(String id) async {
    try {
      final doc = await fireStore.collection('bookings').doc(id).get();
      if (doc.exists) {
        return Right(BookingModel.fromJson(doc.data() as Map<String, dynamic>));
      } else {
        return const Left(ServerFailure('Booking not found.'));
      }
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingModel>>> getBookingsByMechanic(
      String mechanicId) async {
    try {
      final snapshot = await fireStore
          .collection('bookings')
          .where('mechanic.id', isEqualTo: mechanicId)
          .get();
      final bookings = snapshot.docs.map((doc) {
        return BookingModel.fromJson(doc.data());
      }).toList();
      return Right(bookings);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingModel>>> getBookingsByDate(
      DateTime date) async {
    try {
      final startOfDay =
          Timestamp.fromDate(DateTime(date.year, date.month, date.day));
      final endOfDay = Timestamp.fromDate(
          DateTime(date.year, date.month, date.day, 23, 59, 59));

      final user = authService.currentUser;

      Query query = fireStore
          .collection('bookings')
          .where('startDateTime', isGreaterThanOrEqualTo: startOfDay)
          .where('startDateTime', isLessThanOrEqualTo: endOfDay);

      final snapshot = await query.get();
      final bookings = snapshot.docs.map((doc) {
        return BookingModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      // TODO: implement composite query in firestore
      // if (user?.role.name == 'mechanic') {
      //   query = query.where('mechanic.id', isEqualTo: user?.id ?? "");
      // }
      if (user?.role.name == 'mechanic') {
        final mechanicId = user?.id ?? "";
        final filteredBookings = bookings
            .where((booking) => booking.mechanic.id == mechanicId)
            .toList();
        return Right(filteredBookings);
      }

      return Right(bookings);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingModel>>> getBookingsInRange(
      DateTime fromDate, DateTime toDate) async {
    try {
      final start = Timestamp.fromDate(fromDate);
      final end = Timestamp.fromDate(
        DateTime(
          toDate.year,
          toDate.month,
          toDate.day,
          23,
          59,
          59,
        ),
      );

      final user = authService.currentUser;

      Query query = fireStore
          .collection('bookings')
          .where('startDateTime', isGreaterThanOrEqualTo: start)
          .where('startDateTime', isLessThanOrEqualTo: end);

      final snapshot = await query.get();
      final bookings = snapshot.docs.map((doc) {
        return BookingModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      if (user?.role.name == 'mechanic') {
        final mechanicId = user?.id ?? "";
        final filteredBookings = bookings
            .where((booking) => booking.mechanic.id == mechanicId)
            .toList();
        return Right(filteredBookings);
      }

      return Right(bookings);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBooking(String id) async {
    try {
      print("DELETING BOOKING ID: $id");
      await fireStore.collection('bookings').doc(id).delete();
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
