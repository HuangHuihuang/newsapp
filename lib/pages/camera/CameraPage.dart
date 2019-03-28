import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'ImagePickerChannel.dart';

class CameraPage extends StatefulWidget {
  CameraPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CameraPageState createState() => new _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  ImagePicker _imagePicker = new ImagePickerChannel();
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
          children: [
            new Expanded(child: new Center(child: _buildImage())),
            _buildButtons()
          ]
      ),
    );
  }

  void captureImage(ImageSource captureMode) async {
    try {
      var imageFile = await _imagePicker.pickImage(imageSource: captureMode);
      setState(() {
        _imageFile = imageFile;
      });
    }
    catch (e) {
      print(e);
    }
  }

  Widget _buildImage() {
    if (_imageFile != null) {
      return new Image.file(_imageFile);
    } else {
      return new Text('Take an image to start', style: new TextStyle(fontSize: 18.0));
    }
  }

  Widget _buildButtons() {
    return new ConstrainedBox(
        constraints: BoxConstraints.expand(height: 80.0),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildActionButton(new Key('retake'), 'Photos', () => captureImage(ImageSource.photos)),
              _buildActionButton(new Key('upload'), 'Camera', () => captureImage(ImageSource.camera)),
            ]
        ));
  }

  Widget _buildActionButton(Key key, String text, Function onPressed) {
    return new Expanded(
      child: new FlatButton(
          key: key,
          child: new Text(text, style: new TextStyle(fontSize: 20.0)),
          shape: new RoundedRectangleBorder(),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: onPressed),
    );
  }

}