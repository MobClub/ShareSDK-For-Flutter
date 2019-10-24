import 'dart:io';
import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sharesdk_plugin_example/home.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //if (Platform.isIOS) {
    	SharesdkPlugin.addRestoreReceiver(_onEvent, _onError);
    //}
  }

  void _onEvent(Object event) {
  	print('>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  	Map resMap_t = event;
  	Map<String, dynamic> resMap = Map<String, dynamic>.from(resMap_t);
  	String path = resMap['path'];
  	Map<String, dynamic> params = Map<String, dynamic>.from(resMap['params']);
  	print(">>>>>>>>>>>>>>>>>>>>>>>>>>> path:$path,params:$params");
    
  }

  void _onError(Object event) {
    setState(() {
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>onError:' + event.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
    );
  }
}