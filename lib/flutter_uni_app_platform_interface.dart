import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_uni_app_method_channel.dart';

abstract class FlutterUniAppPlatform extends PlatformInterface {
  /// Constructs a FlutterUniAppPlatform.
  FlutterUniAppPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUniAppPlatform _instance = MethodChannelFlutterUniApp();

  /// The default instance of [FlutterUniAppPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUniApp].
  static FlutterUniAppPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUniAppPlatform] when
  /// they register themselves.
  static set instance(FlutterUniAppPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
