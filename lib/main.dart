// This example shows a [Scaffold] with an [AppBar], a [BottomAppBar] and a
// [FloatingActionButton]. The [body] is a [Text] placed in a [Center] in order
// to center the text within the [Scaffold] and the [FloatingActionButton] is
// centered and docked within the [BottomAppBar] using
// [FloatingActionButtonLocation.centerDocked]. The [FloatingActionButton] is
// connected to a callback that increments a counter.

import 'package:flutter/material.dart';
import 'package:hub_news/pages/weather/WeatherPage.dart';
import 'package:hub_news/pages/SecondPage.dart';
import 'package:hub_news/pages/InfoPage.dart';

void main() => runApp(MyApp());

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
    SecondPage(),
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
          BottomNavigationBarItem(title: new Text("Weather"), icon: new Icon(Icons.home)),
          BottomNavigationBarItem(title: new Text("News"), icon: new Icon(Icons.cast_connected)),
          BottomNavigationBarItem(title: new Text("Info"), icon: new Icon(Icons.info))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
              _currentIndex++;
            }),
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
