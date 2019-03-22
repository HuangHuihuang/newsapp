import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hub_news/pages/weather/WeatherData.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {

  WeatherData weatherData = WeatherData.empty();

  WeatherPageState() {
    _getWeather();
  }

  void _getWeather() async {
    WeatherData data = await _fetchWeather();
    setState(() {
      weatherData = data;
    });
  }

  Future<WeatherData> _fetchWeather() async {
    final response = await http.get('https://free-api.heweather.net/s6/weather/now?location=深圳&key=115640aa60b44bca981c4d938e41381d');
    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    }else {
      return WeatherData.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.asset("images/weather_bg.jpg", fit: BoxFit.fitHeight,),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 80.0),
                child: new Text("深圳", textAlign: TextAlign.center, style: new TextStyle(color: Colors.white, fontSize: 30.0,),),
              ),
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 100.0),
                child: new Column(
                  children: <Widget>[
                    new Text(weatherData?.tmp, style: new TextStyle(color: Colors.white, fontSize: 80.0),),
                    new Text(weatherData?.cond, style: new TextStyle(color: Colors.white, fontSize: 45.0),),
                    new Text(weatherData?.hum, style: new TextStyle(color: Colors.white, fontSize: 30.0),),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}