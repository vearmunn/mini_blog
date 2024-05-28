import 'package:fpdart/fpdart.dart';
import 'package:mini_blog/core/errors/failure.dart';
import 'package:mini_blog/core/usecase/usecase_interface.dart';
import 'package:mini_blog/features/auth/domain/repository/auth_repository.dart';

class UserSignOut implements UseCase<dynamic, NoParams> {
  final AuthRepository authRepository;

  UserSignOut(this.authRepository);
  @override
  Future<Either<Failure, dynamic>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
