import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ImageSource {
  photos,
  camera
}

String _stringImageSource(ImageSource imageSource) {
  switch (imageSource) {
    case ImageSource.photos: return 'photos';
    case ImageSource.camera: return 'camera';
  }
}

abstract class ImagePicker {
  Future<File> pickImage({ImageSource imageSource});
}

class ImagePickerChannel implements ImagePicker {

  // 这里创建一个MethodChannel，并取个名字
  static const platform = const MethodChannel('com.hubert.hub_news/imagePicker');

  Future<File> pickImage({ImageSource imageSource}) async {

    var stringImageSource = _stringImageSource(imageSource);
    var result = await platform.invokeMethod('pickImage', stringImageSource);
    if (result is String) {
      return new File(result);
    } else if (result is FlutterError) {
      throw result;
    }
    return null;
  }
}