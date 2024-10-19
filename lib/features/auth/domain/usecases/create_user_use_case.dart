import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';
import '../entities/user_entity.dart';

class CreateUserUseCase extends UseCase<void, CreateUserParams> {
  final UserRepository userRepository;

  CreateUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, void>> call(CreateUserParams params) {
    // Pass the UserEntity instead of parameters
    return userRepository.createUser(params.user);
  }
}

class CreateUserParams {
  final UserEntity user;

  CreateUserParams({required this.user});
}
