import 'package:either_dart/either.dart';
import 'package:pin_app_challenge_post_sdk/pin_app_challenge_post_sdk.dart';

class PostSwiftDatasource {
  final PinAppChallengePostSdk sdk;

  PostSwiftDatasource(this.sdk);

  Future<Either<Exception, List<Comment>>> getComments(
      {required int postId}) async {
    final comments = await sdk.getComments(postId);

    if (comments == null) {
      return Left(Exception('Failed to load comments'));
    } else {
      return Right(comments);
    }
  }
}
