part of 'comments_bloc.dart';

@freezed
class CommentsState with _$CommentsState {
  const factory CommentsState({
    @Default(false) bool isLoading,
    @Default([]) List<Comment> comments,
    @Default(false) bool showErrorDialog,
  }) = _CommentsState;
}
