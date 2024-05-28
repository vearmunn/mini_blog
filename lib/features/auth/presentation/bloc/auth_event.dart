part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUp(this.name, this.email, this.password);
}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn(this.email, this.password);
}

final class FetchUserData extends AuthEvent {}

final class AuthSignOut extends AuthEvent {
  final BuildContext context;

  AuthSignOut(this.context);
}
