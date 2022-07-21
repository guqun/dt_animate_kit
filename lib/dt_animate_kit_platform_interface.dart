import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dt_animate_kit_method_channel.dart';

abstract class DtAnimateKitPlatform extends PlatformInterface {
  /// Constructs a DtAnimateKitPlatform.
  DtAnimateKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static DtAnimateKitPlatform _instance = MethodChannelDtAnimateKit();

  /// The default instance of [DtAnimateKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelDtAnimateKit].
  static DtAnimateKitPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DtAnimateKitPlatform] when
  /// they register themselves.
  static set instance(DtAnimateKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
