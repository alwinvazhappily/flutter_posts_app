import 'package:flutter/material.dart';
import 'package:flutter_posts_app/core/constants/typedef_constants.dart';
import 'package:flutter_posts_app/core/widgets/connection_error_widget.dart';
import 'package:flutter_posts_app/presentation/screens/posts/widgets/post_card.dart';
import 'package:flutter_posts_app/presentation/viewmodels/post_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListScreen extends ConsumerWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Posts',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(postViewModelProvider.notifier).refreshPosts(),
          ),
        ],
      ),
      body: postsAsync.when(
        data: (posts) => RefreshIndicator(
          onRefresh: () =>
              ref.read(postViewModelProvider.notifier).refreshPosts(),
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) => PostCard(post: posts[index]),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: RC.w16 * RH.widthMultiplier!,
              vertical: RC.h8 * RH.heightMultiplier!,
            ),
            child: ConnectionErrorWidget(
              context: context,
              description: 'Error: $error',
              press: () =>
                  ref.read(postViewModelProvider.notifier).refreshPosts(),
            ),
          ),
        ),
      ),
    );
  }
}
