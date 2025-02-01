import 'package:flutter_posts_app/core/failures/app_failure.dart';
import 'package:flutter_posts_app/data/datasources/local/database_service.dart';
import 'package:flutter_posts_app/data/datasources/remote/api_service.dart';
import 'package:flutter_posts_app/data/models/post_model.dart';
import 'package:flutter_posts_app/domain/repositories/i_post_repository.dart';
import 'package:fpdart/fpdart.dart';

class PostRepository implements IPostRepository {
  final ApiService _apiService;
  final DatabaseService _databaseService;

  PostRepository(this._apiService, this._databaseService);

  @override
  Future<Either<AppFailure, List<Post>>> getPosts() async {
    try {
      final localPosts = await _databaseService.getPosts();

      if (localPosts.isEmpty) {
        return refreshPosts();
      }

      return right(localPosts);
    } catch (e) {
      return left(AppFailure('Database error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<AppFailure, List<Post>>> refreshPosts() async {
    try {
      final result = await _apiService.fetchPosts();
      return result.fold(
        (failure) => left(failure),
        (posts) async {
          final saveResult = await savePosts(posts);
          return saveResult.fold(
            (failure) => left(failure),
            (_) => right(posts),
          );
        },
      );
    } catch (e) {
      return left(AppFailure('Refresh error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<AppFailure, Post>> getPostById(int id) async {
    try {
      final localPost = await _databaseService.getPostById(id);
      if (localPost != null) {
        return right(localPost);
      }
      return _apiService.fetchPostById(id);
    } catch (e) {
      return left(AppFailure('Failed to get post: ${e.toString()}'));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> savePosts(List<Post> posts) async {
    try {
      await _databaseService.insertPosts(posts);
      return right(unit);
    } catch (e) {
      return left(AppFailure('Failed to save posts: ${e.toString()}'));
    }
  }
}
