import 'package:flutter_posts_app/core/failures/app_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppFailure', () {
    test('should create AppFailure with default message', () {
      // Act
      final failure = AppFailure();

      // Assert
      expect(failure.message, 'Sorry, an unexpected error occurred!');
    });

    test('should create AppFailure with custom message', () {
      // Arrange
      const message = 'Custom error message';

      // Act
      final failure = AppFailure(message);

      // Assert
      expect(failure.message, message);
    });

    test('toString should return correct string representation', () {
      // Arrange
      const message = 'Test message';
      final failure = AppFailure(message);

      // Act & Assert
      expect(failure.toString(), 'AppFailure(message: Test message)');
    });
  });
}
