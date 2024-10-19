import 'package:dartz/dartz.dart';
import '../models/user_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/enums/user_role.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failure, UserModel>> registerUser(String email, String password, String name, UserRole role);
  Future<Either<Failure, UserModel>> loginUser(String email, String password);
  Future<Either<Failure, void>> logoutUser();
  Future<Either<Failure, List<UserModel>>> getAllMechanics();
  Future<Either<Failure, UserModel>> getUserById(String id);
  Future<Either<Failure, void>> createUser(UserModel user);
}
