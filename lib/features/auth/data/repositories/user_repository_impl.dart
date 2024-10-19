import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../../../../core/enums/user_role.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> registerUser(String email, String password, String name, UserRole role) async {
    final result = await remoteDataSource.registerUser(email, password, name, role);
    return result.map((userModel) => userModel.toEntity());
  }

  @override
  Future<Either<Failure, UserEntity>> loginUser(String email, String password) async {
    final result = await remoteDataSource.loginUser(email, password);
    return result.map((userModel) => userModel.toEntity());
  }

  @override
  Future<Either<Failure, void>> logoutUser() async {
    return await remoteDataSource.logoutUser();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllMechanics() async {
    final result = await remoteDataSource.getAllMechanics();
    return result.map((userModels) => userModels.map((model) => model.toEntity()).toList());
  }

}
