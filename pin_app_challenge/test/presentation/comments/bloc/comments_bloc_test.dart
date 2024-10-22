import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_app_challenge/data/repositories/post_repository_impl.dart';
import 'package:pin_app_challenge/domain/entities/api_error.dart';
import 'package:pin_app_challenge/presentation/comments/bloc/comments_bloc.dart';
import 'package:pin_app_challenge_post_sdk/entities/comment.dart';

import '../../home/bloc/home_bloc_test.mocks.dart';

@GenerateMocks([PostRepositoryImpl])
void main() {
  late CommentsBloc bloc;
  late MockPostRepositoryImpl mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepositoryImpl();
    bloc = CommentsBloc(mockPostRepository);
  });

  provideDummy<Either<ApiError, List<Comment>>>(const Right([]));

  group('CommentsBloc', () {
    final tComment = Comment(
        id: 1,
        postId: 1,
        name: 'Test Title',
        email: 'Test Email',
        body: 'Test Body');
    final tCommentList = [tComment];

    blocTest<CommentsBloc, CommentsState>(
      'emits [PostLoading, PostLoaded] when getPosts is successful',
      build: () {
        when(mockPostRepository.getComments(any)).thenAnswer(
          (_) async => Right(tCommentList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetComments(postId: 1)),
      expect: () => [
        const CommentsState(isLoading: true),
        CommentsState(
          isLoading: false,
          comments: tCommentList,
        )
      ],
      verify: (_) {
        verify(mockPostRepository.getComments(any)).called(1);
      },
    );

    blocTest<CommentsBloc, CommentsState>(
      'emits [PostLoading, PostError] when getPosts is unsuccessful',
      build: () {
        when(mockPostRepository.getComments(any)).thenAnswer(
          (_) async => const Left(ApiError(code: '1', message: 'Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetComments(postId: 1)),
      expect: () => [
        const CommentsState(isLoading: true),
        const CommentsState(
          isLoading: false,
          showErrorDialog: true,
        ),
        const CommentsState(
          showErrorDialog: false,
        ),
      ],
      verify: (_) {
        verify(mockPostRepository.getComments(any)).called(1);
      },
    );
  });
}
