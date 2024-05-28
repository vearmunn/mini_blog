part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class PostBlog extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  PostBlog(
      {required this.posterId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});
}

class GetAllBlogs extends BlogEvent {}
