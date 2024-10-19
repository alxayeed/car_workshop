import 'package:car_workshop/features/auth/data/datasources/user_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';
import '../../../../core/enums/user_role.dart';

class FirebaseAuthDataSource implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDataSource(this.firebaseAuth);

  @override
  Future<Either<Failure, UserModel>> registerUser(String email, String password, String name, UserRole role) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return Right(UserModel(
          id: userCredential.user!.uid,
          email: email,
          name: name,
          role: role,
        ));
      } else {
        return const Left(ServerFailure('User creation failed.'));
      }
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'An error occurred during registration.'));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return Right(UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          name: '',
          role: UserRole.mechanic,
        ));
      } else {
        return const Left(ServerFailure('Login failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'An error occurred during login.'));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logoutUser() async {
    try {
      await firebaseAuth.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'An error occurred during logout.'));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllMechanics() async {
    try {
      return const Right([]);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserById(String id) async {
    try {
      return Right(UserModel(id: id, email: '', name: '', role: UserRole.mechanic));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
