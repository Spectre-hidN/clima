import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class Location {
  
  double? _longitude;
  double? _latitude;

  Future<void> fetchGeoLocation() async {
    try {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low, timeLimit: const Duration(seconds: 5));
    _longitude = position.longitude;
    _latitude  = position.latitude;
    debugPrint("Location data fetched successfully");
    } catch (e) {
      LocationPermission perm = await Geolocator.checkPermission();
      perm == LocationPermission.denied ? debugPrint ("Permission Denied!") : debugPrint("Couldn't able to fetch the location.");
      debugPrint("Defaulting it to GooglePlex, Mountain View, CA, USA...");
    }
  }



  //Returns the location of GooglePlex, Mountain View, CA, USA if no value is set.
  Map<String, double> getLocation() {
    return {'longitude'  : _longitude ?? -122.0848018,
            'latitude' : _latitude ??  37.4221318 
           };
  }

}

//51.52107806084777, -0.05101038525098615