part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

final class NoUser extends AuthState {
  // final String message;

  // AuthFailure(this.message);
}

final class AuthSignedOut extends AuthState {
  final String message;

  AuthSignedOut(this.message);
}
