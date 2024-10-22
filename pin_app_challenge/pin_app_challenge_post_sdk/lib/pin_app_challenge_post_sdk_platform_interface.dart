import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pin_app_challenge_post_sdk_method_channel.dart';

abstract class PinAppChallengePostSdkPlatform extends PlatformInterface {
  /// Constructs a PinAppChallengePostSdkPlatform.
  PinAppChallengePostSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static PinAppChallengePostSdkPlatform _instance = MethodChannelPinAppChallengePostSdk();

  /// The default instance of [PinAppChallengePostSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelPinAppChallengePostSdk].
  static PinAppChallengePostSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PinAppChallengePostSdkPlatform] when
  /// they register themselves.
  static set instance(PinAppChallengePostSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
