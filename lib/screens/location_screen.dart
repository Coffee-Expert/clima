import 'package:clima_kevin/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_kevin/constants/Constants.dart';
import 'package:clima_kevin/services/Weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temprature;
  late String conditionemoji;
  late String message;
  late String cityName;
  late int min;
  late int humidity;
  late int max;
  late String desp;
  late int feels_like = 0;
  WeatherModel Wm = new WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dynamic Wdata = widget.locationWeather;
    setState(() {
      print(Wdata);
      updateUI(Wdata);
    });
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      print(weatherData);
      double temp = weatherData['main']['temp'];
      temprature = temp.toInt();
      double feels = weatherData['main']['feels_like'];
      feels_like = feels.toInt();
      int cond = weatherData['weather'][0]['id'];
      conditionemoji = Wm.getWeatherIcon(cond);
      desp = weatherData['weather'][0]['description'];
      double mini = weatherData['main']['temp_min'];
      min = mini.toInt();
      double maxi = weatherData['main']['temp_max'];
      max = maxi.toInt();
      humidity = weatherData['main']['humidity'];
      cityName = weatherData['name'];
      message = Wm.getMessage(temprature);
      print('Update UI has been run');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await Wm.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.my_location,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var CityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (CityName != null) {
                        var WeatherData = await Wm.getCityWeather(CityName);
                        updateUI(WeatherData);
                        print(WeatherData['name']);
                        updateUI(WeatherData);
                      }
                    },
                    child: Icon(
                      Icons.search_outlined,
                      size: 55.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 0.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temprature°',
                        style: TextStyle(
                            fontFamily: 'Spartan MB',
                            fontSize: 140.0,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(conditionemoji, style: kTempTextStyle),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 10.0),
                child: Text(
                  "○ Expect $desp",
                  style: kInfoTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 0.0),
                child: Text(
                  "○ Humidity: $humidity %",
                  style: kInfoTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 0.0),
                child: Text(
                  '○ Feels like: $feels_like°',
                  style: kInfoTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 0.0),
                child: Text(
                  "○ Today's minimum: $min°",
                  style: kInfoTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 0.0),
                child: Text(
                  "○ Today's maximum: $max°",
                  style: kInfoTextStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0, top: 35.0),
                  child: Text(
                    "$message in  $cityName!",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'Spartan MB',
                        fontSize: 60.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
