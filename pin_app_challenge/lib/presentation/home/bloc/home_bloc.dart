import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pin_app_challenge/domain/entities/post.dart';
import 'package:pin_app_challenge/domain/repositories/post_repository.dart';

part 'home_bloc.freezed.dart';
part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostRepository _postRepository;

  HomeBloc(this._postRepository) : super(const HomeState()) {
    on<GetPosts>(_getPosts);
  }

  Future<void> _getPosts(GetPosts event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    final res = await _postRepository.getPosts();

    res.fold(
      (l) {
        emit(
          state.copyWith(
            isLoading: false,
            showErrorDialog: true,
          ),
        );
        emit(state.copyWith(showErrorDialog: false));
      },
      (r) {
        emit(state.copyWith(isLoading: false, posts: r));
      },
    );
  }
}
