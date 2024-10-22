import 'package:pin_app_challenge_post_sdk/entities/comment.dart';

import 'pin_app_challenge_post_sdk_platform_interface.dart';

export 'package:pin_app_challenge_post_sdk/entities/comment.dart';
export 'package:pin_app_challenge_post_sdk/pin_app_challenge_post_sdk_platform_interface.dart';

class PinAppChallengePostSdk {
  Future<List<Comment>?> getComments(int postId) {
    return PinAppChallengePostSdkPlatform.instance.getComments(postId);
  }
}
