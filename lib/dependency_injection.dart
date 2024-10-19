import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'features/auth/data/datasources/firebase_auth_data_source.dart';
import 'features/auth/data/datasources/user_remote_datasource.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/domain/usecases/login_use_case.dart';
import 'features/auth/domain/usecases/logout_use_case.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';

class DependencyInjection {
  static void initDependencies() {
    // Data Sources
    Get.lazyPut<FirebaseAuth>(() => FirebaseAuth.instance);
    Get.lazyPut<UserRemoteDataSource>(() => FirebaseAuthDataSource(Get.find()));

    // Repositories
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()));

    // Use Cases
    Get.lazyPut<RegisterUserUseCase>(() => RegisterUserUseCase(Get.find()));
    Get.lazyPut<LoginUserUseCase>(() => LoginUserUseCase(Get.find()));
    Get.lazyPut<LogoutUserUseCase>(() => LogoutUserUseCase(Get.find()));

    // Controllers
    Get.lazyPut<AuthController>(() => AuthController(
      Get.find<RegisterUserUseCase>(),
      Get.find<LoginUserUseCase>(),
      Get.find<LogoutUserUseCase>(),
    ));
  }
}
