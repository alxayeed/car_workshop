import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'features/auth/data/datasources/firebase_auth_data_source.dart';
import 'features/auth/data/datasources/user_remote_datasource.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/domain/usecases/create_user_use_case.dart';
import 'features/auth/domain/usecases/login_use_case.dart';
import 'features/auth/domain/usecases/logout_use_case.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/bookings/data/datasources/booking_remote_data_source.dart';
import 'features/bookings/data/datasources/firebase_booking_data_source.dart';
import 'features/bookings/data/repositories/booking_repository_impl.dart';
import 'features/bookings/domain/repositories/booking_repository.dart';
import 'features/bookings/domain/usecases/add_booking_use_case.dart';
import 'features/bookings/domain/usecases/fetch_bookings_use_case.dart';
import 'features/bookings/presentation/controllers/booking_controller.dart';

class DependencyInjection {
  static void initDependencies() {
    // Data Sources
    Get.lazyPut<FirebaseAuth>(() => FirebaseAuth.instance);
    Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance);

    Get.lazyPut<UserRemoteDataSource>(() => FirebaseAuthDataSource(
          Get.find<FirebaseAuth>(),
          Get.find<FirebaseFirestore>(),
        ));

    Get.lazyPut<BookingRemoteDataSource>(
        () => FirebaseBookingDataSource(Get.find<FirebaseFirestore>()));

    // Repositories
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()));
    Get.lazyPut<BookingRepository>(() => BookingRepositoryImpl(Get.find()));

    // Use Cases
    Get.lazyPut<CreateUserUseCase>(() => CreateUserUseCase(Get.find()));
    Get.lazyPut<RegisterUserUseCase>(
        () => RegisterUserUseCase(Get.find(), Get.find<CreateUserUseCase>()));
    Get.lazyPut<LoginUserUseCase>(() => LoginUserUseCase(Get.find()));
    Get.lazyPut<LogoutUserUseCase>(() => LogoutUserUseCase(Get.find()));
    Get.lazyPut<FetchBookingsUseCase>(() => FetchBookingsUseCase(Get.find()));
    Get.lazyPut<AddBookingUseCase>(() => AddBookingUseCase(Get.find()));

    // Controllers
    Get.lazyPut<AuthController>(() => AuthController(
          Get.find<RegisterUserUseCase>(),
          Get.find<LoginUserUseCase>(),
          Get.find<LogoutUserUseCase>(),
        ));
    Get.lazyPut<BookingsController>(
      () => BookingsController(
        Get.find<FetchBookingsUseCase>(),
        Get.find(),
      ),
    );
  }
}
