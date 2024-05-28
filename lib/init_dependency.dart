import 'package:get_it/get_it.dart';
import 'package:mini_blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mini_blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mini_blog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mini_blog/features/auth/domain/repository/auth_repository.dart';
import 'package:mini_blog/features/auth/domain/usecases/current_user.dart';
import 'package:mini_blog/features/auth/domain/usecases/sign_out.dart';
import 'package:mini_blog/features/auth/domain/usecases/user_signin.dart';
import 'package:mini_blog/features/auth/domain/usecases/user_signup_.dart';
import 'package:mini_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:mini_blog/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:mini_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:mini_blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:mini_blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secret.dart';
import 'features/blog/domain/usecases/fetch_all_blogs.dart';

final serviceLocator = GetIt.instance;

Future initDependency() async {
  _initAuth();
  _initBlog();
  final supabase =
      await Supabase.initialize(url: AppSecret.url, anonKey: AppSecret.anonKey);

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignIn(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignOut(serviceLocator()));

  serviceLocator.registerLazySingleton(() => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
      userSignOut: serviceLocator()));
}

void _initBlog() {
  //Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(serviceLocator()))

    //Repository
    ..registerFactory<BlogRepository>(
        () => BlogRepositoryImpl(serviceLocator()))

    //Usecase
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => FetchAllBlogs(serviceLocator()))

    //Bloc
    ..registerLazySingleton(() => BlogBloc(
        uploadBlog: serviceLocator(), fetchAllBlogs: serviceLocator()));
}
