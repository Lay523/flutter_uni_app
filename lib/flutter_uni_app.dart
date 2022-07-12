
import 'flutter_uni_app_platform_interface.dart';

class FlutterUniApp {
  Future<String?> getPlatformVersion() {
    return FlutterUniAppPlatform.instance.getPlatformVersion();
  }
}
