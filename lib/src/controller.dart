/*
 * @Created on 2022/7/13 10:31 上午 
 * @Author Lay523
 * @Description TODO
 */

import 'package:flutter/services.dart';

class UniMpController{

  static late MethodChannel _channel;

  UniMpController(String appId){
    _channel = MethodChannel('lay/flutter_uni_app_$appId');
    _channel.setMethodCallHandler(_onMethodCall);
  }

  Future<void> _onMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onUniMPEventCallBack':

        break;
      default:
        throw PlatformException(
          code: 'UniMpController',
          message: 'UniMpController: Unknown method ${call.method}',
        );
    }

  }

  /// get the uni_app appId
  static Future<String> get getAppId async {
    return await _channel.invokeMethod<String>('getAppId') ?? '';
  }

  /// get the uni_app current page path
  static Future<String> get getCurrentPagePath async {
    return await _channel.invokeMethod<String>('getCurrentPagePath') ?? '';
  }

  /// send the uni_app event
  static Future<void> sendEvent(String eventName,{
    Map<String, dynamic>? params,
  }) async {
    await _channel.invokeMethod('sendEvent',{
      'eventName': eventName,
      'params': params,
    });
  }

  /// is the uni_app is running
  static Future<bool> get isAppRunning async {
    return await _channel.invokeMethod<bool>('isAppRunning') ?? false;
  }

  /// show the uni_app
  static Future<void> showUniMp() async {
    await _channel.invokeMethod('showUniMp');
  }

  /// hide the uni_app
  static Future<void> hideUniMp() async {
    await _channel.invokeMethod('hideUniMp');
  }

  /// close the uni_app
  static Future<void> closeUniMp() async {
    await _channel.invokeMethod('closeUniMp');
  }

  /// dispose
  void dispose(){
    _channel.setMethodCallHandler(null);
  }
}