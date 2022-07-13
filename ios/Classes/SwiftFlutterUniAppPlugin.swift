import Flutter
import UIKit
import FlutterUniAppMp


public class SwiftFlutterUniAppPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "lay/flutter_uni_app", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterUniAppPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if call.method == "getPlatformVersion"{
          result("iOS " + UIDevice.current.systemVersion)
      } else if call.method == "initEngine"{
          let options = NSMutableDictionary.init()
          let debug = getBoolFromCall(key: "debug", call: call)
          options.setValue(NSNumber.init(value:debug), forKey: "debug")
          DCUniMPSDKEngine.initSDKEnvironment(launchOptions: options as! [AnyHashable : Any]);
          result(true)
      } else if call.method == "isEngineInitialized"{

          

      } else if call.method == "isAppExist"{
          let appId: String = getStringFromCall(key: "appId", call: call)
          let res = DCUniMPSDKEngine.isExistsUniMP(appId)
          result(res)
      } else if call.method == "getAppVersion"{
          let appId: String = getStringFromCall(key: "appId", call: call)
          let info = DCUniMPSDKEngine.getUniMPVersionInfo(withAppid: appId)
          result(info)
      } else if call.method == "isNeedUpdateUniMP"{
          let appId: String = getStringFromCall(key: "appId", call: call)
          let version: NSNumber = getNumberFromCall(key: "versionCode", call: call)
          if DCUniMPSDKEngine.isExistsUniMP(appId){
              let info = DCUniMPSDKEngine.getUniMPVersionInfo(withAppid: appId)
              let oldCode = info?["code"] as? NSNumber ?? 0
              let res = version.compare(oldCode)
              if res == ComparisonResult.orderedDescending{
                  result(true)
                  return
              }
          }
          result(false)
      } else if call.method == "installUniMPResource"{
          let appId: String = getStringFromCall(key: "appId", call: call)
          let path: String = getStringFromCall(key: "wgtPath", call: call)
          let key = FlutterDartProject.lookupKey(forAsset: path)
          let wgtPath = String.init(format: "%@/%@", Bundle.main.resourcePath!,key)
          let password = (call.arguments as? Dictionary<String, Any>)?["password"] as? String
          do {
            try DCUniMPSDKEngine.installUniMPResource(withAppid: appId, resourceFilePath: wgtPath, password: password)
              print("✅ 小程序：\(appId) 资源释放成功")
              result(true)
          } catch let err as NSError {
              print("❌ 小程序：\(appId) 资源释放失败:\(err)")
              result(false)
          }
      } else if call.method == "closeCurrentApp"{
          DCUniMPSDKEngine.closeUniMP();
      } else if call.method == "getAppBasePath"{
          let appId: String = getStringFromCall(key: "appId", call: call)
          let path: String = DCUniMPSDKEngine.getUniMPRunPath(withAppid: appId)
          result(path)
      } else if call.method == "openUniApp"{
          let appId: String = getStringFromCall(key: "appId", call: call)
          if !DCUniMPSDKEngine.isExistsUniMP(appId){
            result(false)
            return
          }
          let extras = getDicFromCall(key: "extras", call: call)
          let configuration = DCUniMPConfiguration.init()
          
          let path = getStringFromCall(key: "path", call: call)
          if path != ""{
              configuration.path = path;
          }
          configuration.extraData = getDicFromCall(key: "arguments", call: call)
          if extras != nil{
              configuration.enableBackground = extras!["enableBackground"] as? Bool
              ?? false
              configuration.showAnimated = extras!["showAnimated"] as? Bool
              ?? true
              configuration.hideAnimated = extras!["hideAnimated"] as? Bool
              ?? true
              configuration.enableGestureClose = extras!["enableGestureClose"] as? Bool
              ?? false
              let openMode = extras!["openMode"] as? String ?? "DCUniMPOpenModePresent"
              
              if openMode == "DCUniMPOpenModePresent"{
                  configuration.openMode = DCUniMPOpenMode.present
              }else if openMode == "DCUniMPOpenModePush"{
                  configuration.openMode = DCUniMPOpenMode.push
              }
          }
          DCUniMPSDKEngine.openUniMP(appId, configuration: configuration) { instance, error in
              if instance != nil {
                  print("小程序打开成功")
              } else {
                  print("❌ 小程序打开失败：\(appId) 资源释放失败:\(error as Any)")
              }
          }
      } else if call.method == "setCapsuleMenuButtonEvent"{
          
          
      } else{
          result(FlutterMethodNotImplemented)
      }
  }
  private func getStringFromCall(key:String,call : FlutterMethodCall) -> String{
     guard let result = (call.arguments as? Dictionary<String, Any>)?[key] as? String else {
        // result(FlutterError(code: "参数异常", message: "参数url不能为空", details: nil))
        return ""
    }
        
    return result
  }
    
    private func getDicFromCall(key:String,call : FlutterMethodCall) -> Dictionary<String, Any>?{
        guard let result = (call.arguments as? Dictionary<String, Any>)?[key] as? Dictionary<String, Any> else {
            return nil
        }
        return result
    }
    
  private func getBoolFromCall(key:String,call : FlutterMethodCall) -> Bool{
        guard let result = (call.arguments as? Dictionary<String, Any>)?[key] as? Bool else {
            return false
        }
        return result
  }
    private func getNumberFromCall(key:String,call : FlutterMethodCall) -> NSNumber{
        guard let result = (call.arguments as? Dictionary<String, Any>)?[key] as? NSNumber else {
            return 0
        }
        return result
    }
}
