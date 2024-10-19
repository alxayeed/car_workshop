import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/enums/user_role.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> registerUser(String email, String password, String name, UserRole role);

  Future<Either<Failure, UserEntity>> loginUser(String email, String password);
  Future<Either<Failure, void>> logoutUser();

  Future<Either<Failure, void>> createUser(UserEntity user);

  Future<Either<Failure, List<UserEntity>>> getAllMechanics();
}
