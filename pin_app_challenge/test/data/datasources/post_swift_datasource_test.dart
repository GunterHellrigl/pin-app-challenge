import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_app_challenge/data/datasources/post_swift_datasource.dart';
import 'package:pin_app_challenge_post_sdk/pin_app_challenge_post_sdk.dart';

import 'post_swift_datasource_test.mocks.dart';

@GenerateMocks([PinAppChallengePostSdk])
void main() {
  late PostSwiftDatasource dataSource;
  late MockPinAppChallengePostSdk mockSdk;

  setUp(() {
    mockSdk = MockPinAppChallengePostSdk();
    dataSource = PostSwiftDatasource(mockSdk);
  });

  group('getComments', () {
    const tPostId = 1;
    final tComment = Comment(
        id: 1,
        postId: tPostId,
        name: 'Test',
        email: 'test@test.com',
        body: 'Test body');
    final tCommentList = [tComment];

    test('should return a list of Comment when the sdk call is successful',
        () async {
      // Arrange
      when(mockSdk.getComments(tPostId)).thenAnswer(
        (_) async => tCommentList,
      );

      // Act
      final result = await dataSource.getComments(postId: tPostId);

      // Assert
      expect(result.isRight, true);
      expect(result.right, tCommentList);
      verify(mockSdk.getComments(tPostId));
      verifyNoMoreInteractions(mockSdk);
    });

    test('should return an Exception when the sdk call returns null', () async {
      // Arrange
      when(mockSdk.getComments(tPostId)).thenAnswer(
        (_) async => null,
      );

      // Act
      final result = await dataSource.getComments(postId: tPostId);

      // Assert
      expect(result.isLeft, true);
      expect(result.left, isA<Exception>());
      verify(mockSdk.getComments(tPostId));
      verifyNoMoreInteractions(mockSdk);
    });
  });
}
