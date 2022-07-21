import 'package:flutter_test/flutter_test.dart';
import 'package:dt_animate_kit/dt_animate_kit.dart';
import 'package:dt_animate_kit/dt_animate_kit_platform_interface.dart';
import 'package:dt_animate_kit/dt_animate_kit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDtAnimateKitPlatform 
    with MockPlatformInterfaceMixin
    implements DtAnimateKitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DtAnimateKitPlatform initialPlatform = DtAnimateKitPlatform.instance;

  test('$MethodChannelDtAnimateKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDtAnimateKit>());
  });

  test('getPlatformVersion', () async {
    DtAnimateKit dtAnimateKitPlugin = DtAnimateKit();
    MockDtAnimateKitPlatform fakePlatform = MockDtAnimateKitPlatform();
    DtAnimateKitPlatform.instance = fakePlatform;
  
    expect(await dtAnimateKitPlugin.getPlatformVersion(), '42');
  });
}
