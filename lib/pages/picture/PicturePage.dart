import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PicturePage extends StatefulWidget {
  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      persistentFooterButtons: <Widget>[
        new FlatButton(
            key: new Key('key'),
            child: new Text('打开相机', style: new TextStyle(fontSize: 20.0)),
            shape: new RoundedRectangleBorder(),
            color: Colors.blueAccent,
            textColor: Colors.white,
            onPressed: getImage)
      ],
    );
  }

}