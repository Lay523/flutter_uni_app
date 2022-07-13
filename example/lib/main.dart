import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_uni_app/flutter_uni_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await FlutterUniApp().platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              TextButton(onPressed: (){
                FlutterUniApp().initEngine();
              }, child: const Text('initEngine')),

              TextButton(onPressed: (){
                FlutterUniApp().installUniMPResource(appId: "__UNI__11E9B73", wgtPath: "assets/__UNI__11E9B73.wgt");
              }, child: const Text('installUniMPResource')),

              TextButton(onPressed: ()async{
                await FlutterUniApp().openUniApp(
                    appId: "__UNI__11E9B73",
                    path: "pages/component/button/button",
                  extras: {
                      'enableGestureClose':true
                  }
                );
              }, child: const Text('openUniApp')),

              TextButton(onPressed: ()async{
                final res = await FlutterUniApp().getAppBasePath;
                print(res);
              }, child: const Text('getAppBasePath')),

              ///getAppVersion
              TextButton(onPressed: ()async{
                final res = await FlutterUniApp().getAppVersion("__UNI__11E9B73");
                print(res);
              }, child: const Text('getAppVersion')),

              TextButton(onPressed: (){
                FlutterUniApp().closeCurrentApp();
              }, child: const Text('closeCurrentApp')),
            ],
          ),
        ),
      ),
    );
  }
}
