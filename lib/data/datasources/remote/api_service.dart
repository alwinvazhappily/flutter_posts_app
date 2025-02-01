import 'dart:convert';
import 'package:flutter_posts_app/core/constants/api_constants.dart';
import 'package:flutter_posts_app/core/failures/app_failure.dart';
import 'package:flutter_posts_app/core/utils/api_helper.dart';
import 'package:flutter_posts_app/data/models/post_model.dart';
import 'package:fpdart/fpdart.dart';

class ApiService {
  Future<Either<AppFailure, List<Post>>> fetchPosts() async {
    try {
      final response =
          await ApiHelper.get('${ApiConstants.baseUrl}${ApiConstants.posts}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final posts = jsonData
            .map((json) => Post.fromMap(json as Map<String, dynamic>))
            .toList();
        return right(posts);
      } else {
        return left(AppFailure(
            'Failed to fetch posts. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      return left(AppFailure('Network error: ${e.toString()}'));
    }
  }

  Future<Either<AppFailure, Post>> fetchPostById(int id) async {
    try {
      final response = await ApiHelper.get(
          '${ApiConstants.baseUrl}${ApiConstants.posts}/$id');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return right(Post.fromMap(jsonData));
      } else {
        return left(AppFailure(
            'Failed to fetch post. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      return left(AppFailure('Network error: ${e.toString()}'));
    }
  }
}
