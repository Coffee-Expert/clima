import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:clima_kevin/services/Weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulseRise,
          colors: [Colors.redAccent, Colors.greenAccent, Colors.lightBlue],
        ),
      ),
    );
  }
}
