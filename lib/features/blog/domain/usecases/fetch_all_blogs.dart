import 'package:fpdart/fpdart.dart';
import 'package:mini_blog/core/errors/failure.dart';
import 'package:mini_blog/core/usecase/usecase_interface.dart';
import 'package:mini_blog/features/blog/domain/entities/blog.dart';
import 'package:mini_blog/features/blog/domain/repositories/blog_repository.dart';

class FetchAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  FetchAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.fetchAllBlogs();
  }
}
