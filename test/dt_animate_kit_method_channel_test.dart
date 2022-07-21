import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dt_animate_kit/dt_animate_kit_method_channel.dart';

void main() {
  MethodChannelDtAnimateKit platform = MethodChannelDtAnimateKit();
  const MethodChannel channel = MethodChannel('dt_animate_kit');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
