import 'package:fpdart/fpdart.dart';
import 'package:mini_blog/core/errors/failure.dart';
import 'package:mini_blog/core/usecase/usecase_interface.dart';
import 'package:mini_blog/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/common/entities/user.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignIn(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.signInwithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
