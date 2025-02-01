import 'package:flutter_posts_app/core/failures/app_failure.dart';
import 'package:flutter_posts_app/data/models/post_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class IPostRepository {
  Future<Either<AppFailure, List<Post>>> getPosts();
  Future<Either<AppFailure, List<Post>>> refreshPosts();
  Future<Either<AppFailure, Post>> getPostById(int id);
  Future<Either<AppFailure, Unit>> savePosts(List<Post> posts);
}
