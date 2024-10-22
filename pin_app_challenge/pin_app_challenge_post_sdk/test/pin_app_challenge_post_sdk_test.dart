import 'package:flutter_test/flutter_test.dart';
import 'package:pin_app_challenge_post_sdk/pin_app_challenge_post_sdk.dart';
import 'package:pin_app_challenge_post_sdk/pin_app_challenge_post_sdk_platform_interface.dart';
import 'package:pin_app_challenge_post_sdk/pin_app_challenge_post_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPinAppChallengePostSdkPlatform
    with MockPlatformInterfaceMixin
    implements PinAppChallengePostSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PinAppChallengePostSdkPlatform initialPlatform = PinAppChallengePostSdkPlatform.instance;

  test('$MethodChannelPinAppChallengePostSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPinAppChallengePostSdk>());
  });

  test('getPlatformVersion', () async {
    PinAppChallengePostSdk pinAppChallengePostSdkPlugin = PinAppChallengePostSdk();
    MockPinAppChallengePostSdkPlatform fakePlatform = MockPinAppChallengePostSdkPlatform();
    PinAppChallengePostSdkPlatform.instance = fakePlatform;

    expect(await pinAppChallengePostSdkPlugin.getPlatformVersion(), '42');
  });
}
