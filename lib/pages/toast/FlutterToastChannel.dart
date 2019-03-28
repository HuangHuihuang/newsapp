import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ToastMode {
  sourceOne,
  sourceTwo
}

String _convertMode2String(ToastMode toastSource) {
  switch (toastSource) {
    case ToastMode.sourceOne: return 'Hello';
    case ToastMode.sourceTwo: return 'World';
  }
}

abstract class FlutterToast {
  Future<String> showToast({ToastMode toastMode});
}

class FlutterToastChannel implements FlutterToast {

  // 这里创建一个MethodChannel，并取个名字
  static const platform = const MethodChannel('com.hubert.hub_news/flutterToast');

  Future<String> showToast({ToastMode toastMode}) async {

    var stringToastSource = _convertMode2String(toastMode);
    var result = await platform.invokeMethod('showToast', stringToastSource);
    if (result is String) {
      print('FlutterToastResult: $result');
      return result;
    } else if (result is FlutterError) {
      throw result;
    }
    return null;
  }
}