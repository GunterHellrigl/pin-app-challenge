import 'package:either_dart/either.dart';
import 'package:pin_app_challenge/data/datasources/post_http_datasource.dart';
import 'package:pin_app_challenge/data/datasources/post_swift_datasource.dart';
import 'package:pin_app_challenge/data/responses/get_posts_response.dart';
import 'package:pin_app_challenge/domain/entities/api_error.dart';
import 'package:pin_app_challenge/domain/entities/post.dart';
import 'package:pin_app_challenge/domain/repositories/post_repository.dart';
import 'package:pin_app_challenge_post_sdk/entities/comment.dart';

class PostRepositoryImpl extends PostRepository {
  final PostHttpDatasource postHttpDatasource;
  final PostSwiftDatasource postSwiftDatasource;

  PostRepositoryImpl(this.postHttpDatasource, this.postSwiftDatasource);

  @override
  Future<Either<ApiError, List<Post>>> getPosts() {
    final res = postHttpDatasource.getPosts();

    return res.then((value) {
      return value.fold(
        (l) {
          return Left(ApiError(code: "101", message: "Error: ${l.toString()}"));
        },
        (r) => Right(r.map((e) => e.toEntity()).toList()),
      );
    });
  }

  @override
  Future<Either<ApiError, List<Comment>>> getComments(int postId) async {
    final res = await postSwiftDatasource.getComments(postId: postId);

    return res.fold(
      (l) {
        return Left(ApiError(code: "101", message: "Error: ${l.toString()}"));
      },
      (r) {
        return Right(r);
      },
    );
  }
}
