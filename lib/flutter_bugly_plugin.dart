import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBuglyPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_bugly_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void setUp(appID) {
    _channel.invokeMethod("setUp",{'app_id':appID});
  }

  static void postException(error, stack) {
    _channel.invokeMethod("postException",{'crash_message':error.toString(),'crash_detail':stack.toString()});
  }
}
