// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mini_blog/core/usecase/usecase_interface.dart';
import 'package:mini_blog/features/auth/domain/usecases/current_user.dart';
import 'package:mini_blog/features/auth/domain/usecases/sign_out.dart';
import 'package:mini_blog/features/auth/domain/usecases/user_signin.dart';

import 'package:mini_blog/features/auth/domain/usecases/user_signup_.dart';
import 'package:mini_blog/features/auth/presentation/widgets/signin_or_signup.dart';

import '../../../../core/common/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final UserSignOut _userSignOut;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserSignOut userSignOut,
  })  : _userSignIn = userSignIn,
        _userSignUp = userSignUp,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _userSignOut = userSignOut,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<FetchUserData>(_onfetchUserData);
    on<AuthSignOut>(_onAuthSignOut);
  }
  void _onAuthSignUp(event, emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
        UserSignUpParams(event.name, event.email, event.password));

    res.fold((failure) => emit(AuthFailure(failure.message)), (user) {
      _appUserCubit.updateUser(user);
      emit(AuthSuccess(user));
    });
  }

  void _onAuthSignIn(event, emit) async {
    emit(AuthLoading());
    final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password));

    res.fold((failure) => emit(AuthFailure(failure.message)), (user) {
      _appUserCubit.updateUser(user);
      emit(AuthSuccess(user));
    });
  }

  void _onfetchUserData(event, emit) async {
    emit(AuthLoading());
    final res = await _currentUser(NoParams());

    res.fold((failure) => emit(NoUser()), (user) {
      print("USER EMAIL: ${user.email}");
      _appUserCubit.updateUser(user);
      emit(AuthSuccess(user));
    });
  }

  void _onAuthSignOut(event, emit) async {
    emit(AuthLoading());
    final res = await _userSignOut(NoParams());

    res.fold((l) => emit(AuthFailure(l.message)), (r) {
      emit(AuthSignedOut(r));
      Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(builder: (_) => const SignInOrSignUp()),
          (route) => false);
    });
  }
}
