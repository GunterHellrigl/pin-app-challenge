
import 'pin_app_challenge_post_sdk_platform_interface.dart';

class PinAppChallengePostSdk {
  Future<String?> getPlatformVersion() {
    return PinAppChallengePostSdkPlatform.instance.getPlatformVersion();
  }
}
