import 'package:flutter/material.dart';
import 'package:clima_kevin/constants/Constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String typedName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100, bottom: 20, right: 5),
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    typedName = value;
                  },
                ),
              ),
              TextButton(
                child: const Text(
                  'Get Weather',
                  style: TextStyle(color: Colors.greenAccent, fontSize: 40),
                ),
                onPressed: () {
                  Navigator.pop(context, typedName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
