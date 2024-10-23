import 'package:get/get.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/usecase/no_params.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthController extends GetxController {
  final RegisterUserUseCase registerUserUseCase;
  final LoginUserUseCase loginUserUseCase;
  final LogoutUserUseCase logoutUserUseCase;

  AuthController(
      this.registerUserUseCase, this.loginUserUseCase, this.logoutUserUseCase);

  var isLoading = false.obs;
  var failureMessage = ''.obs;

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;
    final result = await registerUserUseCase
        .call(RegisterParams(name: name, email: email, password: password));
    isLoading.value = false;

    result.fold(
      (Failure failure) {
        failureMessage.value = failure.message;
        SnackbarService.showErrorMessage(failure.message);
      },
      (_) {
        SnackbarService.showSuccessMessage(AppStrings.registrationSuccess);
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUserUseCase
        .call(LoginParams(email: email, password: password));
    isLoading.value = false;

    result.fold(
      (Failure failure) {
        failureMessage.value = failure.message;
        SnackbarService.showErrorMessage(failure.message);
      },
      (_) {
        Get.offAllNamed(AppRoutes.bookings);
      },
    );
  }

  Future<void> logout() async {
    isLoading.value = true;
    final result = await logoutUserUseCase.call(NoParams());
    isLoading.value = false;

    result.fold(
      (Failure failure) {
        failureMessage.value = failure.message;
        SnackbarService.showErrorMessage(failure.message);
      },
      (_) {
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}
