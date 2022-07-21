import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dt_animate_kit_platform_interface.dart';

/// An implementation of [DtAnimateKitPlatform] that uses method channels.
class MethodChannelDtAnimateKit extends DtAnimateKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dt_animate_kit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
