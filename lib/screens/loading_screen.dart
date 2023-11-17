import 'package:clima/services/location.dart';
import 'package:clima/screens/location_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {

  const LoadingScreen({super.key});
  

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
   
  Map<String, double> location = Location().getLocation();

  void jumpToNextScreen({required double temp, required String weatherIcon, required String placeName}) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      int finalTemp = temp.round() - 273;
      String weatherMessage;
      weatherMessage = "${WeatherModel().getMessage(finalTemp)} in $placeName";
      return LocationScreen(
        tempRounded: finalTemp,
        weatherIcon: weatherIcon,
        weatherMessage: weatherMessage,
        );
    }));
   
  void _initiate() async {

    WeatherData weather = await WeatherModel().getLocationWeather();

    jumpToNextScreen(
      temp: weather.temp,
      weatherIcon: WeatherModel().getWeatherIcon(weather.weatherID),
      placeName: weather.placeName
      );
  }

  @override
  void initState() {
    super.initState();
    _initiate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitSpinningLines(color: Colors.white),
      ),
    );
  }
}
