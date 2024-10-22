import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pin_app_challenge_post_sdk_platform_interface.dart';

/// An implementation of [PinAppChallengePostSdkPlatform] that uses method channels.
class MethodChannelPinAppChallengePostSdk extends PinAppChallengePostSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pin_app_challenge_post_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
