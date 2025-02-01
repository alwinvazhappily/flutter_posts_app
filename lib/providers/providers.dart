import 'package:flutter_posts_app/data/datasources/local/database_service.dart';
import 'package:flutter_posts_app/data/datasources/remote/api_service.dart';
import 'package:flutter_posts_app/data/repositories/post_repository.dart';
import 'package:flutter_posts_app/domain/repositories/i_post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
DatabaseService databaseService(Ref ref) {
  return DatabaseService();
}

@riverpod
ApiService apiService(Ref ref) {
  return ApiService();
}

@riverpod
IPostRepository postRepository(Ref ref) {
  return PostRepository(
    ref.watch(apiServiceProvider),
    ref.watch(databaseServiceProvider),
  );
}
