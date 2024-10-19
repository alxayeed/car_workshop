import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class LoginUserUseCase implements UseCase<void, LoginParams> {
  final UserRepository repository;

  LoginUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(LoginParams params) {
    return repository.loginUser(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
