import 'package:dartz/dartz.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';
import 'create_user_use_case.dart';

class RegisterUserUseCase implements UseCase<void, RegisterParams> {
  final UserRepository repository;
  final CreateUserUseCase createUserUseCase;

  RegisterUserUseCase(this.repository, this.createUserUseCase);

  @override
  Future<Either<Failure, void>> call(RegisterParams params) async {
    const role = UserRole.mechanic;

    final registrationResult = await repository.registerUser(
      params.email,
      params.password,
      params.name,
      role,
    );

    return registrationResult.fold(
          (failure) => Left(failure),
          (userEntity) async {

        return await createUserUseCase.call(CreateUserParams(user: userEntity));
      },
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
