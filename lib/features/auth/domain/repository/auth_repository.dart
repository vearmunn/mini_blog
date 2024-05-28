import 'package:fpdart/fpdart.dart';
import 'package:mini_blog/core/common/entities/user.dart';

import '../../../../core/errors/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpwithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signInwithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
  Future<Either<Failure, dynamic>> signOut();
}
