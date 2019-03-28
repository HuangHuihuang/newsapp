import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'FlutterToastChannel.dart';

class ToastPage extends StatefulWidget {
  ToastPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ToastPageState createState() => new _ToastPageState();
}

class _ToastPageState extends State<ToastPage> {
  FlutterToast _flutterToastPlugin = new FlutterToastChannel();
  String _textContent;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
          children: [
            new Expanded(child: new Center(child: _buildText())),
            _buildButtons()
          ]
      ),
    );
  }

  void showClientToast(ToastMode toastMode) async {
    try {
      var toastContent = await _flutterToastPlugin.showToast(toastMode: toastMode);
      setState(() {
        _textContent = toastContent;
      });
    }
    catch (e) {
      print(e);
    }
  }

  Widget _buildText() {
    if (_textContent != null) {
      return new Text('$_textContent', style: new TextStyle(fontSize: 18.0));
    } else {
      return new Text('Click Button to invoke client method', style: new TextStyle(fontSize: 18.0));
    }
  }

  Widget _buildButtons() {
    return new ConstrainedBox(
        constraints: BoxConstraints.expand(height: 80.0),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildActionButton(new Key('retake'), 'Hello', () => showClientToast(ToastMode.sourceOne)),
              _buildActionButton(new Key('upload'), 'World', () => showClientToast(ToastMode.sourceTwo)),
            ]
        ));
  }

  Widget _buildActionButton(Key key, String text, Function onPressed) {
    return new Expanded(
      child: new FlatButton(
          key: key,
          child: new Text(text, style: new TextStyle(fontSize: 20.0)),
          shape: new RoundedRectangleBorder(),
          color: Colors.white,
          textColor: Colors.blueAccent,
          onPressed: onPressed),
    );
  }

}