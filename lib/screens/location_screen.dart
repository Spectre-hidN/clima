import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  
  final int tempRounded;
  final String weatherIcon;
  final String weatherMessage;

  const LocationScreen({
    super.key, 
    required this.tempRounded, 
    required this.weatherIcon,
    required this.weatherMessage
    });

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {

  int? _tempRounded;
  String? _weatherIcon;
  String? _weatherMessage;

  @override
  void initState(){
    super.initState();
    _tempRounded = _tempRounded ?? widget.tempRounded;
    _weatherIcon = _weatherIcon ?? widget.weatherIcon;
    _weatherMessage = _weatherMessage ?? widget.weatherMessage;
  }

  void updateWeather({required UpdateType type, String? cityName}) async {
     
    WeatherData weather = type == UpdateType.currentLocation ? await WeatherModel().getLocationWeather() : await WeatherModel().getCityWeather(cityName.toString());

    setState(() {
      _tempRounded = int.parse(weather.temp.round().toString()) - 273;
      _weatherIcon = WeatherModel().getWeatherIcon(weather.weatherID);
      _weatherMessage = "${WeatherModel().getMessage(int.parse(_tempRounded.toString()))} in ${weather.placeName}";
    });
    
    debugPrint("Weather updated for the current location {longitude : ${weather.longitude.toString()}, latitude : ${weather.latitude.toString()}}.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      updateWeather(type: UpdateType.currentLocation);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var locationInput = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const CityScreen();
                      },));
                      if(locationInput != null) {
                        updateWeather(type: UpdateType.remoteLocation, cityName: locationInput);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${_tempRounded.toString()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      _weatherIcon.toString(),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  _weatherMessage.toString(),
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
