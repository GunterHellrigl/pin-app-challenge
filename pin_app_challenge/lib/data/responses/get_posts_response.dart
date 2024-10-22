import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pin_app_challenge/domain/entities/post.dart';

part 'get_posts_response.freezed.dart';
part 'get_posts_response.g.dart';

@freezed
class PostResponse with _$PostResponse {
  const factory PostResponse({
    required int userId,
    required int id,
    required String title,
    required String body,
  }) = _PostResponse;

  factory PostResponse.fromJson(Map<String, Object?> json) =>
      _$PostResponseFromJson(json);
}

extension PostResponseX on PostResponse {
  Post toEntity() {
    return Post(
      id: id,
      title: title,
      body: body,
    );
  }
}
