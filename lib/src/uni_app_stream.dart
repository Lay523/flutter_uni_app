/*
 * @Created on 2022/7/13 11:31 上午 
 * @Author Lay523
 * @Description TODO
 */

import 'dart:async';

import 'event.dart';

class UniAppStream{

  final StreamController<IUniAppEvent> _eventCtrl = StreamController.broadcast();

  Stream<IUniAppEvent> get onUniAppEvent => _eventCtrl.stream;

  void formJson(String method,Map<String,dynamic> args){
    IUniAppEvent? event;
    switch (method) {
      case 'CapsuleCloseButtonEvent':
        event = CapsuleCloseButtonEvent.fromJson(args);
        break;
      case 'UniMPEvent':
        event = UniMPEvent.fromJson(args);
        break;
      case 'CapsuleMenuButtonEvent':
        event = CapsuleMenuButtonEvent.fromJson(args);
        break;
      case 'DefMenuButtonClickEvent':
        event = DefMenuButtonClickEvent.fromJson(args);
        break;
      case 'UniMPOnCloseEvent':
        event = UniMPOnCloseEvent.fromJson(args);
        break;
    }
    if(event != null){
      _eventCtrl.add(event);
    }
  }

  void addEvent(IUniAppEvent event){
    _eventCtrl.add(event);
  }

  Stream<CapsuleMenuButtonEvent> get onCapsuleMenuButtonEvent {
    return _eventCtrl.stream.where((event) => event is CapsuleMenuButtonEvent).cast<CapsuleMenuButtonEvent>();
  }

  Stream<UniMPEvent> get onUniMPEventCallBack {
    return _eventCtrl.stream.where((event) => event is UniMPEvent).cast<UniMPEvent>();
  }

  Stream<CapsuleCloseButtonEvent> get onCapsuleCloseButtonEvent {
    return _eventCtrl.stream.where((event) => event is CapsuleCloseButtonEvent).cast<CapsuleCloseButtonEvent>();
  }

  Stream<DefMenuButtonClickEvent> get onDefMenuButtonClickEvent {
    return _eventCtrl.stream.where((event) => event is DefMenuButtonClickEvent).cast<DefMenuButtonClickEvent>();
  }

  Stream<UniMPOnCloseEvent> get onUniMPOnCloseEvent {
    return _eventCtrl.stream.where((event) => event is UniMPOnCloseEvent).cast<UniMPOnCloseEvent>();
  }



}