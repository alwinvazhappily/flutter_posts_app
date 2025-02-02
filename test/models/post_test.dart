import 'package:flutter_posts_app/data/models/post_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post Model', () {
    const testId = 1;
    const testTitle = 'test title';
    const testBody = 'test body';

    test('fromMap() should return a valid model', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'id': testId,
        'title': testTitle,
        'body': testBody,
      };

      // Act
      final result = Post.fromMap(jsonMap);

      // Assert
      expect(result, isA<Post>());
      expect(result.id, testId);
      expect(result.title, testTitle);
      expect(result.body, testBody);
    });

    test('fromMap() should handle null id', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'title': testTitle,
        'body': testBody,
      };

      // Act
      final result = Post.fromMap(jsonMap);

      // Assert
      expect(result.id, -1);
      expect(result.title, testTitle);
      expect(result.body, testBody);
    });

    test('fromMap() should handle empty strings', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'id': testId,
        'title': null,
        'body': null,
      };

      // Act
      final result = Post.fromMap(jsonMap);

      // Assert
      expect(result.id, testId);
      expect(result.title, '');
      expect(result.body, '');
    });

    test('toMap() should return a valid map', () {
      // Arrange
      final post = Post(id: testId, title: testTitle, body: testBody);

      // Act
      final map = post.toMap();

      // Assert
      expect(map, {
        'id': testId,
        'title': testTitle,
        'body': testBody,
      });
    });

    test('copyWith() should return object with updated fields', () {
      // Arrange
      final post = Post(id: testId, title: testTitle, body: testBody);

      // Act
      final updatedPost = post.copyWith(
        title: 'new title',
        body: 'new body',
      );

      // Assert
      expect(updatedPost.id, post.id);
      expect(updatedPost.title, 'new title');
      expect(updatedPost.body, 'new body');
    });

    test(
        'copyWith() should retain original values if new ones are not provided',
        () {
      // Arrange
      final post = Post(id: testId, title: testTitle, body: testBody);

      // Act
      final updatedPost = post.copyWith();

      // Assert
      expect(updatedPost.id, post.id);
      expect(updatedPost.title, post.title);
      expect(updatedPost.body, post.body);
    });
  });
}
