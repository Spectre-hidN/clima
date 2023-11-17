import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const String apiKey = 'd3c9ed45d6b582fe3abd6e7619c9ed67';
const String apiEndPoint  = 'https://api.openweathermap.org/data/2.5/weather?';

enum UpdateType {
  currentLocation,
  remoteLocation
}