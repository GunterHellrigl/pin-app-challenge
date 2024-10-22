import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_app_challenge/data/datasources/post_http_datasource.dart';
import 'package:pin_app_challenge/data/datasources/post_swift_datasource.dart';
import 'package:pin_app_challenge/data/repositories/post_repository_impl.dart';
import 'package:pin_app_challenge/data/responses/get_posts_response.dart';
import 'package:pin_app_challenge/domain/entities/api_error.dart';
import 'package:pin_app_challenge_post_sdk/entities/comment.dart';

import 'post_repository_impl_test.mocks.dart';

@GenerateMocks([PostHttpDatasource, PostSwiftDatasource])
void main() {
  late MockPostHttpDatasource mockPostHttpDatasource;
  late MockPostSwiftDatasource mockPostSwiftDatasource;
  late PostRepositoryImpl repository;

  setUp(() {
    mockPostHttpDatasource = MockPostHttpDatasource();
    mockPostSwiftDatasource = MockPostSwiftDatasource();
    repository =
        PostRepositoryImpl(mockPostHttpDatasource, mockPostSwiftDatasource);
  });

  // Proporcionar un valor dummy para Either<Exception, List<PostResponse>>
  provideDummy<Either<Exception, List<PostResponse>>>(const Right([]));
  provideDummy<Either<Exception, List<Comment>>>(const Right([]));

  group('getPosts', () {
    const tPostResponse = PostResponse(
      userId: 1,
      id: 1,
      title: 'Test Title',
      body: 'Test Body',
    );
    final tPostList = [tPostResponse];
    final tPostEntityList = tPostList.map((e) => e.toEntity()).toList();

    test(
        'should return a list of posts when the call to datasource is successful',
        () async {
      // Arrange
      when(mockPostHttpDatasource.getPosts()).thenAnswer(
        (_) async => Right(tPostList),
      );

      // Act
      final result = await repository.getPosts();

      // Assert
      expect(result.isRight, true);
      expect(result.right, tPostEntityList);
      verify(mockPostHttpDatasource.getPosts());
      verifyNoMoreInteractions(mockPostHttpDatasource);
    });

    test(
        'should return an ApiError when the call to datasource is unsuccessful',
        () async {
      // Arrange
      when(mockPostHttpDatasource.getPosts()).thenAnswer(
        (_) async => Left(Exception('Error')),
      );

      // Act
      final result = await repository.getPosts();

      // Assert
      expect(result.isLeft, true);
      expect(result.left, isA<ApiError>());
      verify(mockPostHttpDatasource.getPosts());
      verifyNoMoreInteractions(mockPostHttpDatasource);
    });
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

    test(
        'should return a list of comments when the call to datasource is successful',
        () async {
      // Arrange
      when(mockPostSwiftDatasource.getComments(postId: tPostId)).thenAnswer(
        (_) async => Right(tCommentList),
      );

      // Act
      final result = await repository.getComments(tPostId);

      // Assert
      expect(result.isRight, true);
      expect(result.right, tCommentList);
      verify(mockPostSwiftDatasource.getComments(postId: tPostId));
      verifyNoMoreInteractions(mockPostSwiftDatasource);
    });

    test(
        'should return an ApiError when the call to datasource is unsuccessful',
        () async {
      // Arrange
      when(mockPostSwiftDatasource.getComments(postId: tPostId)).thenAnswer(
        (_) async => Left(Exception('Error')),
      );

      // Act
      final result = await repository.getComments(tPostId);

      // Assert
      expect(result.isLeft, true);
      expect(result.left, isA<ApiError>());
      verify(mockPostSwiftDatasource.getComments(postId: tPostId));
      verifyNoMoreInteractions(mockPostSwiftDatasource);
    });
  });
}
