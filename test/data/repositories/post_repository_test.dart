import 'package:flutter_posts_app/core/failures/app_failure.dart';
import 'package:flutter_posts_app/data/datasources/local/database_service.dart';
import 'package:flutter_posts_app/data/datasources/remote/api_service.dart';
import 'package:flutter_posts_app/data/models/post_model.dart';
import 'package:flutter_posts_app/data/repositories/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

class MockApiService extends Mock implements ApiService {}

void main() {
  late PostRepository repository;
  late MockDatabaseService mockDatabaseService;
  late MockApiService mockApiService;

  setUp(() {
    mockDatabaseService = MockDatabaseService();
    mockApiService = MockApiService();
    repository = PostRepository(mockApiService, mockDatabaseService);
  });

  group('getPosts', () {
    final tPosts = [
      Post(id: 1, title: 'test title', body: 'test body'),
    ];

    test('should return cached posts when available', () async {
      // Arrange
      when(() => mockDatabaseService.getPosts())
          .thenAnswer((_) async => tPosts);

      // Act
      final result = await repository.getPosts();

      // Assert
      expect(result.isRight(), true);
      verify(() => mockDatabaseService.getPosts()).called(1);
      verifyNever(() => mockApiService.fetchPosts());
    });

    test('should fetch from API when cache is empty', () async {
      // Arrange
      when(() => mockDatabaseService.getPosts()).thenAnswer((_) async => []);
      when(() => mockApiService.fetchPosts())
          .thenAnswer((_) async => right(tPosts));
      when(() => mockDatabaseService.insertPosts(any()))
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.getPosts();

      // Assert
      expect(result.isRight(), true);
      verify(() => mockApiService.fetchPosts()).called(1);
      verify(() => mockDatabaseService.insertPosts(any())).called(1);
    });

    test('should return failure when both cache and API fail', () async {
      // Arrange
      when(() => mockDatabaseService.getPosts())
          .thenThrow(Exception('Database error'));
      when(() => mockApiService.fetchPosts())
          .thenAnswer((_) async => left(AppFailure('API error')));

      // Act
      final result = await repository.getPosts();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.message, contains('Database error')),
        (_) => fail('Should return failure'),
      );
    });
  });
}
