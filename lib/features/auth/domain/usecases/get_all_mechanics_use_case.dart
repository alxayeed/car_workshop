import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/no_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetAllMechanicsUseCase implements UseCase<List<UserEntity>, NoParams> {
  final UserRepository repository;
  final GetStorage storage;

  GetAllMechanicsUseCase(this.repository, this.storage);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    final Either<Failure, List<UserEntity>> result =
        await repository.getAllMechanics();

    return result.fold(
      (failure) => Left(failure),
      (mechanics) async {
        await _saveMechanicsToLocal(mechanics);
        return Right(mechanics);
      },
    );
  }

  Future<void> _saveMechanicsToLocal(List<UserEntity> mechanics) async {
    final List<Map<String, dynamic>> mechanicsJson =
        mechanics.map((mechanic) => mechanic.toModel().toJson()).toList();
    await storage.write('mechanics', mechanicsJson);
  }
}
