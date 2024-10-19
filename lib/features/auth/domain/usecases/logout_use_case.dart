import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/no_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class LogoutUserUseCase implements UseCase<void, NoParams> {
  final UserRepository repository;

  LogoutUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.logoutUser();
  }
}
