import 'package:clima/utilities/constants.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

class WeatherData {
  final int resultCode;
  final double longitude;
  final double latitude;
  final int weatherID;
  final String weatherMain;
  final String weatherDesc;
  final double temp;
  final double feelsLike;
  final double tempMax;
  final double tempMin;
  final int pressure;
  final int humidity;
  final int visibility;
  final double windSpeed;
  final String countryCode;
  final String placeName;


  WeatherData({
    required this.resultCode,
    required this.longitude,
    required this.latitude,
    required this.weatherID,
    required this.weatherMain,
    required this.weatherDesc,
    required this.temp,
    required this.feelsLike,
    required this.tempMax,
    required this.tempMin,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.countryCode,
    required this.placeName
  });

}

class WeatherModel {

  Future<WeatherData> getCityWeather(String cityName) async {
    String url = "${apiEndPoint}q=$cityName&appid=$apiKey";

    Request requestObj = Request(url: url);
    WeatherData weather = await requestObj.getWeatherData();

    return weather;
  }

  Future<WeatherData> getLocationWeather() async {

    Location locationData = Location();
    await locationData.fetchGeoLocation();
    Map<String, double> location = locationData.getLocation();

    String url = "${apiEndPoint}lat={LATITUDE}&lon={LONGITUDE}&appid={APIKEY}";
    url = url.replaceAll("{LATITUDE}", location['latitude'].toString());
    url = url.replaceAll("{LONGITUDE}", location['longitude'].toString());
    url = url.replaceAll("{APIKEY}", apiKey);

    Request requestObj = Request(url: url);
    WeatherData weather = await requestObj.getWeatherData();

    return weather;
  
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
