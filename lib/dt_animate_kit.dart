
import 'dt_animate_kit_platform_interface.dart';

class DtAnimateKit {
  Future<String?> getPlatformVersion() {
    return DtAnimateKitPlatform.instance.getPlatformVersion();
  }
}
