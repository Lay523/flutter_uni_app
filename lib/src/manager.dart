/*
 * @Created on 2022/7/13 10:48 上午 
 * @Author Lay523
 * @Description TODO
 */


import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_uni_app/src/event.dart';

import 'call_back.dart';
import 'uni_app_stream.dart';


class FlutterUniApp {

  static const MethodChannel _channel = MethodChannel('lay/flutter_uni_app');

  static final FlutterUniApp _instance = FlutterUniApp._();

  FlutterUniApp._(){
    _channel.setMethodCallHandler(_onMethodCall);
  }

  factory FlutterUniApp() {
    return _instance;
  }

  final UniAppStream stream = UniAppStream();

  /// 设置小程序胶囊按钮点击"..."菜单事件监听，设置后原菜单弹窗逻辑将不再执行！交由宿主实现相关逻辑。v3.2.6
  Future<Stream<CapsuleMenuButtonEvent>> setCapsuleMenuButtonEvent() async{
    await _channel.invokeMethod('setCapsuleMenuButtonEvent');
    return stream.onCapsuleMenuButtonEvent;
  }

  Stream<UniMPEvent> get onUniMPEventCallBack => stream.onUniMPEventCallBack;

  Stream<CapsuleCloseButtonEvent> get onCapsuleCloseButtonEvent => stream.onCapsuleCloseButtonEvent;

  Stream<DefMenuButtonClickEvent> get onDefMenuButtonClickEvent => stream.onDefMenuButtonClickEvent;

  Stream<UniMPOnCloseEvent> get onUniMPOnCloseEvent => stream.onUniMPOnCloseEvent;


  static final Map<CallBackType, Function?> _callBackMaps = {

  };


  Future<void> _onMethodCall(MethodCall call) async {
    final args = call.arguments as Map<String, dynamic>;
    if (call.method.contains('Event')) {
      stream.formJson(call.method, args);
      return;
    }

  }

  Future<String?> get platformVersion async {
    return _channel.invokeMethod<String>('getPlatformVersion');
  }



  /// init the uni_app engine
  Future<void> initEngine({bool debug = true}) async {
    await _channel.invokeMethod('initEngine',{'debug':debug});
  }

  /// is the uni_app engine initialized
  Future<bool> get isEngineInitialized async {
    return await _channel.invokeMethod<bool>('isEngineInitialized') ?? false;
  }

  /// is the uni_app exist
  Future<bool> isAppExist(String appId) async {
    final result = await _channel.invokeMethod<bool>('isAppExist',{
      'appId': appId,
    });
    return result ?? false;
  }

  /// get the uni_app version
  Future<Map<String,dynamic>?> getAppVersion(String appId) async {
    final result = await _channel.invokeMethod('getAppVersion',{
      'appId': appId,
    });
    return Map<String, dynamic>.from(result);
  }

  /// install wgt to run app path
  Future<bool> installUniMPResource({
    required String appId,
    required String wgtPath,
    String? password,
  }) async {
    final result = await _channel.invokeMethod<bool>('installUniMPResource',{
      'appId': appId,
      'wgtPath': wgtPath,
      'password': password,
    });
    return result ?? false;
  }

  /// close current app
  Future<void> closeCurrentApp() async {
    await _channel.invokeMethod('closeCurrentApp');
  }

  /// get the uni_app run path
  Future<String?> get getAppBasePath async {
    return await _channel.invokeMethod<String>('getAppBasePath');
  }

  /// open the uni_app
  /// @params extras the ios
  /// extras: {
  ///  "enableBackground": false, 是否开启后台运行（退出小程序时隐藏到后台不销毁小程序应用） 默认：NO*
  ///  "showAnimated": "true, 是否开启 show 小程序时的动画效果 默认：YES
  ///  "hideAnimated": true,是否开启 hide 时的动画效果 默认：YES
  ///  "openMode": "DCUniMPOpenModePresent",打开小程序的方式 默认： DCUniMPOpenModePresent
  ///  "enableGestureClose": false,是否开启手势关闭小程序 默认：NO
  ///  }
  Future<void> openUniApp({
    required String appId,
    String? path,
    Map<String, dynamic>? arguments,
    Map<String, dynamic>? extras,
  }) async {
    await _channel.invokeMethod('openUniApp', {
      'appId': appId,
      'path': path,
      'arguments': arguments,
      'extras': extras,
    });
  }


  /// 判断是否需要更新小程序
  Future<bool> isNeedUpdateUniMP({
    required String appId,
    required int versionCode,
  }) async {
    final result = await _channel.invokeMethod<bool>('isNeedUpdateUniMP',{
      'appId': appId,
      'versionCode': versionCode,
    });
    return result ?? false;
  }



}