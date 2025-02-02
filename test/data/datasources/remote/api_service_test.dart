import 'dart:convert';

import 'package:flutter_posts_app/core/constants/api_constants.dart';
import 'package:flutter_posts_app/data/datasources/remote/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ApiService apiService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiService = ApiService();
    registerFallbackValue(Uri.parse(''));
  });

  group('fetchPosts', () {
    final tPostsList = [
      {
        'id': 1,
        'title': 'test title',
        'body': 'test body',
      }
    ];

    test('should return list of posts when response is 200', () async {
      // Arrange
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response(json.encode(tPostsList), 200));

      // Act
      final result = await apiService.fetchPosts();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should not return failure'),
        (posts) {
          expect(posts.length, 1);
          expect(posts.first.id, 1);
          expect(posts.first.title, 'test title');
        },
      );
      verify(() => mockHttpClient.get(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.posts}'))).called(1);
    });

    test('should return failure when response is not 200', () async {
      // Arrange
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('Error', 404));

      // Act
      final result = await apiService.fetchPosts();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.message, contains('Failed to fetch posts')),
        (_) => fail('Should return failure'),
      );
    });

    test('should return failure when exception occurs', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(Exception('Test error'));

      // Act
      final result = await apiService.fetchPosts();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.message, contains('Network error')),
        (_) => fail('Should return failure'),
      );
    });
  });
}
