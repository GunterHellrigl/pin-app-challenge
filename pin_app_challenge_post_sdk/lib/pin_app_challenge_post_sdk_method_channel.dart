import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pin_app_challenge_post_sdk/entities/comment.dart';

import 'pin_app_challenge_post_sdk_platform_interface.dart';

class MethodChannelPinAppChallengePostSdk
    extends PinAppChallengePostSdkPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('pin_app_challenge_post_sdk');

  @override
  Future<List<Comment>?> getComments(int postId) async {
    final List<dynamic>? result = await methodChannel
        .invokeMethod<List<dynamic>?>('getComments', {'postId': postId});
    if (result == null) return null;
    return result.map((item) => Comment.fromMap(item)).toList();
  }
}
