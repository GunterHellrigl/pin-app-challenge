import 'package:either_dart/either.dart';
import 'package:pin_app_challenge/domain/entities/api_error.dart';
import 'package:pin_app_challenge/domain/entities/post.dart';
import 'package:pin_app_challenge_post_sdk/entities/comment.dart';

abstract class PostRepository {
  Future<Either<ApiError, List<Post>>> getPosts();
  Future<Either<ApiError, List<Comment>>> getComments(int postId);
}
