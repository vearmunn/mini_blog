import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:mini_blog/core/errors/exception.dart';
import 'package:mini_blog/core/errors/failure.dart';
import 'package:mini_blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:mini_blog/features/blog/data/models/blog_models.dart';
import 'package:mini_blog/features/blog/domain/entities/blog.dart';
import 'package:mini_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> topics}) async {
    try {
      BlogModel blogData = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topics,
          updatedAt: DateTime.now());

      final imageUrl =
          await blogRemoteDataSource.uploadImage(image: image, blog: blogData);

      blogData = blogData.copyWith(imageUrl: imageUrl);

      final uploadedBlog =
          await blogRemoteDataSource.uploadBlog(blog: blogData);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> fetchAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.fetchAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
