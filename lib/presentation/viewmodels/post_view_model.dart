import 'package:flutter_posts_app/data/models/post_model.dart';
import 'package:flutter_posts_app/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_view_model.g.dart';

@riverpod
class PostViewModel extends _$PostViewModel {
  @override
  Future<List<Post>> build() async {
    final result = await ref.watch(postRepositoryProvider).getPosts();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (posts) => posts,
    );
  }

  Future<void> refreshPosts() async {
    state = const AsyncValue.loading();
    final result = await ref.read(postRepositoryProvider).refreshPosts();
    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (posts) => AsyncValue.data(posts),
    );
  }
}
