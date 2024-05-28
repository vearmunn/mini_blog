// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_blog/core/usecase/usecase_interface.dart';

import 'package:mini_blog/features/blog/domain/usecases/upload_blog.dart';

import '../../domain/entities/blog.dart';
import '../../domain/usecases/fetch_all_blogs.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final FetchAllBlogs fetchAllBlogs;
  BlogBloc({
    required this.uploadBlog,
    required this.fetchAllBlogs,
  }) : super(BlogInitial()) {
    on<PostBlog>(_onPostBlog);
    on<GetAllBlogs>(_onGetAllBlogs);
  }
  void _onPostBlog(event, emit) async {
    emit(BlogLoading());
    final res = await uploadBlog(UplaodBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));

    res.fold(
        (l) => emit(BlogFailure(l.message)), (r) => emit(BlogUploadSuccess()));
  }

  void _onGetAllBlogs(event, emit) async {
    emit(BlogLoading());
    final res = await fetchAllBlogs(NoParams());
    res.fold((l) => emit(BlogFailure(l.message)),
        (r) => emit(BlogDisplaySuccess(r)));
  }
}
