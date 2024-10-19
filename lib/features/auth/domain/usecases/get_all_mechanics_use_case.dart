import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/no_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';
import '../entities/user_entity.dart';

class GetAllMechanicsUseCase implements UseCase<List<UserEntity>, NoParams> {
  final UserRepository repository;

  GetAllMechanicsUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) {
    return repository.getAllMechanics();
  }
}
