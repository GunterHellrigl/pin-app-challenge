import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pin_app_challenge/domain/repositories/post_repository.dart';
import 'package:pin_app_challenge_post_sdk/entities/comment.dart';

part 'comments_bloc.freezed.dart';
part 'comments_state.dart';
part 'comments_event.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final PostRepository _postRepository;

  CommentsBloc(this._postRepository) : super(const CommentsState()) {
    on<GetComments>(_getComments);
  }

  Future<void> _getComments(
    GetComments event,
    Emitter<CommentsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final res = await _postRepository.getComments(event.postId);

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
        emit(state.copyWith(isLoading: false, comments: r));
      },
    );
  }
}
