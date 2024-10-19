import 'package:dartz/dartz.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class RegisterUserUseCase implements UseCase<void, RegisterParams> {
  final UserRepository repository;

  RegisterUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterParams params) {
    const role = UserRole.mechanic;
    return repository.registerUser(
      params.email,
      params.password,
      params.name,
      role,
    );
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
