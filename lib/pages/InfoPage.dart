import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new InfoPageState();
}

class InfoPageState extends State<InfoPage> with TickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 500));

    CurvedAnimation curve = CurvedAnimation(
        parent: animationController,
        curve: Curves.decelerate);
    animation = Tween(begin: 0.0, end: 1.0).animate(curve);

    super.initState();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new ScaleTransition(
      scale: animation,
      child: new Container(
        margin: new EdgeInsets.all(30.0),
        child: new Center(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _getTittle(),
              _getContentSecond("github", "源码地址", "https://github.com/HuangHuihuang/newsapp.git"),
              _getContentSecond("Flutter", "Flutter中文网", "https://flutterchina.club/"),
              _getContentSecond("资料", "各种资料汇总", "https://github.com/AweiLoveAndroid/Flutter-learning"),
            ],
          ),
        ),
      ),
    );
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("Third"),
//      ),
//      body: new Center(
//        child: new Text("我是第三页"),
//      ),
//    );
  }

  Widget _getTittle() {
    return Center(
      child: new Text("Flutter News",
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 25.0),
      ),
    );
  }

  Widget _getContentSecond(tittle,tittleLink,link) {

    return new Container(
      margin: new EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
          new Text(tittle),
          new GestureDetector(
            child: new Text(
              tittleLink,
              style: new TextStyle(color: Colors.blue),
            ),
            onTap: (){
              _launchURL(link);
            },
          )
        ],
      ),
    );
  }

  _launchURL(url) async {
    await launch(url);
  }
}