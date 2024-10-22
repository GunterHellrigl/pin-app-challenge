part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<Post> posts,
    @Default(false) bool showErrorDialog,
    @Default(false) bool hideErrorDialog,
  }) = _HomeState;
}
