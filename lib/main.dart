// This example shows a [Scaffold] with an [AppBar], a [BottomAppBar] and a
// [FloatingActionButton]. The [body] is a [Text] placed in a [Center] in order
// to center the text within the [Scaffold] and the [FloatingActionButton] is
// centered and docked within the [BottomAppBar] using
// [FloatingActionButtonLocation.centerDocked]. The [FloatingActionButton] is
// connected to a callback that increments a counter.

import 'package:flutter/material.dart';
import 'package:hub_news/pages/camera/CameraPage.dart';
import 'package:hub_news/pages/picture/PicturePage.dart';
import 'package:hub_news/pages/weather/WeatherPage.dart';
import 'package:hub_news/pages/SecondPage.dart';
import 'package:hub_news/pages/InfoPage.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main() {
  _initJPush();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

  final List<Widget> _children = [
    WeatherPage(),
    // CameraPage(title: '相机调用'),
    PicturePage(),
    InfoPage()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Sample Code'),
//      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(title: new Text("Weather"), icon: new Icon(Icons.wb_sunny)),
          BottomNavigationBarItem(title: new Text("Camera"), icon: new Icon(Icons.camera)),
          BottomNavigationBarItem(title: new Text("Info"), icon: new Icon(Icons.person))
        ],
      ),

// 这里先不用FloatingActionButton了
//      floatingActionButton: FloatingActionButton(
//        onPressed: () => setState(() {
//            _currentIndex = (_currentIndex + 1) % 3;
//            }),
//        tooltip: 'Increment Counter',
//        child: Icon(Icons.add),
//      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

void _initJPush() {
  JPush jPush = new JPush();

  jPush.applyPushAuthority(new NotificationSettingsIOS(
      sound: true,
      alert: true,
      badge: true
  ));

  jPush.setup(
    appKey: "f02e0e851ee9b8184fc3b6ec",
    channel: "developer-default",
    production: false,
    debug: true,
  );
  jPush.getRegistrationID().then((rid) { });

  jPush.addEventHandler(
    // 接收通知回调方法。
    onReceiveNotification: (Map<String, dynamic> message) async {
      print("flutter onReceiveNotification: $message");
    },
    // 点击通知回调方法。
    onOpenNotification: (Map<String, dynamic> message) async {
      print("flutter onOpenNotification: $message");
    },
    // 接收自定义消息回调方法。
    onReceiveMessage: (Map<String, dynamic> message) async {
      print("flutter onReceiveMessage: $message");
    },
  );
}
