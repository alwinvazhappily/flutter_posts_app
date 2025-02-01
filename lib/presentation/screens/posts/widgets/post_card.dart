import 'package:flutter/material.dart';
import 'package:flutter_posts_app/core/constants/typedef_constants.dart';
import 'package:flutter_posts_app/data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: RC.w16 * RH.widthMultiplier!,
        vertical: RC.h8 * RH.heightMultiplier!,
      ),
      child: ListTile(
        title: Text(
          post.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: RC.h8 * RH.heightMultiplier!),
          child: Text(
            post.body,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
