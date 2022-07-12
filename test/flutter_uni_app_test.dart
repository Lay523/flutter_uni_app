import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uni_app/flutter_uni_app.dart';
import 'package:flutter_uni_app/flutter_uni_app_platform_interface.dart';
import 'package:flutter_uni_app/flutter_uni_app_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUniAppPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterUniAppPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterUniAppPlatform initialPlatform = FlutterUniAppPlatform.instance;

  test('$MethodChannelFlutterUniApp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUniApp>());
  });

  test('getPlatformVersion', () async {
    FlutterUniApp flutterUniAppPlugin = FlutterUniApp();
    MockFlutterUniAppPlatform fakePlatform = MockFlutterUniAppPlatform();
    FlutterUniAppPlatform.instance = fakePlatform;
  
    expect(await flutterUniAppPlugin.getPlatformVersion(), '42');
  });
}
