import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_app_challenge/data/repositories/post_repository_impl.dart';
import 'package:pin_app_challenge/domain/entities/api_error.dart';
import 'package:pin_app_challenge/domain/entities/post.dart';
import 'package:pin_app_challenge/presentation/home/bloc/home_bloc.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([PostRepositoryImpl])
void main() {
  late HomeBloc bloc;
  late MockPostRepositoryImpl mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepositoryImpl();
    bloc = HomeBloc(mockPostRepository);
  });

  provideDummy<Either<ApiError, List<Post>>>(const Right([]));

  group('HomeBloc', () {
    const tPost = Post(id: 1, title: 'Test Title', body: 'Test Body');
    final tPostList = [tPost];

    blocTest<HomeBloc, HomeState>(
      'emits [PostLoading, PostLoaded] when getPosts is successful',
      build: () {
        when(mockPostRepository.getPosts()).thenAnswer(
          (_) async => Right(tPostList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetPosts()),
      expect: () => [
        const HomeState(isLoading: true),
        HomeState(
          isLoading: false,
          posts: tPostList,
        )
      ],
      verify: (_) {
        verify(mockPostRepository.getPosts()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [PostLoading, PostError] when getPosts is unsuccessful',
      build: () {
        when(mockPostRepository.getPosts()).thenAnswer(
          (_) async => const Left(ApiError(code: '1', message: 'Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetPosts()),
      expect: () => [
        const HomeState(isLoading: true),
        const HomeState(
          isLoading: false,
          showErrorDialog: true,
        ),
        const HomeState(
          showErrorDialog: false,
        ),
      ],
      verify: (_) {
        verify(mockPostRepository.getPosts()).called(1);
      },
    );
  });
}
