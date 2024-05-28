import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:mini_blog/core/errors/failure.dart';
import 'package:mini_blog/core/usecase/usecase_interface.dart';
import 'package:mini_blog/features/blog/domain/repositories/blog_repository.dart';

import '../entities/blog.dart';

class UploadBlog implements UseCase<Blog, UplaodBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UplaodBlogParams params) async {
    return await blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        posterId: params.posterId,
        topics: params.topics);
  }
}

class UplaodBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UplaodBlogParams(
      {required this.posterId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});
}
