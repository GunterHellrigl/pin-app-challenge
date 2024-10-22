import 'package:pin_app_challenge_post_sdk/entities/comment.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pin_app_challenge_post_sdk_method_channel.dart';

abstract class PinAppChallengePostSdkPlatform extends PlatformInterface {
  PinAppChallengePostSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static PinAppChallengePostSdkPlatform _instance =
      MethodChannelPinAppChallengePostSdk();

  static PinAppChallengePostSdkPlatform get instance => _instance;

  static set instance(PinAppChallengePostSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<Comment>?> getComments(int postId) {
    throw UnimplementedError('getComments() has not been implemented.');
  }
}
