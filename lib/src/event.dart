/*
 * @Created on 2022/7/13 10:57 上午 
 * @Author Lay523
 * @Description TODO
 */

abstract class IUniAppEvent{
  String get appId;
}


/// 设置小程序胶囊按钮点击"..."菜单事件监听，设置后原菜单弹窗逻辑将不再执行！交由宿主实现相关逻辑。v3.2.6
class CapsuleMenuButtonEvent implements IUniAppEvent{
  @override
  final String appId;

  const CapsuleMenuButtonEvent(this.appId);

  factory CapsuleMenuButtonEvent.fromJson(Map<String, dynamic> json) {
    return CapsuleMenuButtonEvent(json['appId'] as String);
  }

  @override
  String toString() {
    return 'CapsuleMenuButtonEvent{appId: $appId}';
  }
}


/// 设置小程序胶囊按钮点击"X"关闭事件监听，设置后原关闭逻辑将不再执行！交由宿主实现相关逻辑。v3.2.6
class CapsuleCloseButtonEvent implements IUniAppEvent{
  @override
  final String appId;

  const CapsuleCloseButtonEvent(this.appId);

  factory CapsuleCloseButtonEvent.fromJson(Map<String, dynamic> json) {
    return CapsuleCloseButtonEvent(json['appId'] as String);
  }

  @override
  String toString() {
    return 'CapsuleCloseButtonEvent{appId: $appId}';
  }
}



class DefMenuButtonClickEvent implements IUniAppEvent{
  @override
  final String appId;

  final String id;


  const DefMenuButtonClickEvent(this.appId, this.id);

  factory DefMenuButtonClickEvent.fromJson(Map<String, dynamic> json) {
    return DefMenuButtonClickEvent(json['appId'] as String, json['id'] as String);
  }

  @override
  String toString() {
    return 'DefMenuButtonClickEvent{appId: $appId, id: $id}';
  }
}


class UniMPOnCloseEvent implements IUniAppEvent{
  @override
  final String appId;

  const UniMPOnCloseEvent(this.appId);

  factory UniMPOnCloseEvent.fromJson(Map<String, dynamic> json) {
    return UniMPOnCloseEvent(json['appId'] as String);
  }

  @override
  String toString() {
    return 'UniMPOnCloseEvent{appId: $appId}';
  }
}


class UniMPEvent implements IUniAppEvent{
  @override
  final String appId;

  final String eventName;

  final Map<String, dynamic>? params;

  const UniMPEvent(this.appId, this.eventName, {this.params});

  factory UniMPEvent.fromJson(Map<String, dynamic> json) {
    return UniMPEvent(
      json['appId'] as String,
      json['eventName'] as String,
      params: json['params'] as Map<String, dynamic>?,
    );
  }

  @override
  String toString() {
    return 'UniMPEventCallBack{appId: $appId, eventName: $eventName, params: $params}';
  }
}