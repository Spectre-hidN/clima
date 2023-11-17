import 'package:http/http.dart' as http;
import 'weather.dart';
import 'dart:convert';

class Request {
  final String url;
  String? resBody;
  Map<String, String>? headers;

  Request({
    required this.url,
    this.headers
  });

  Future<WeatherData> getWeatherData() async {

    http.Response response = await http.get(Uri.parse(url));
    resBody = response.body;
    Map decodedJson = jsonDecode(response.body);

    WeatherData weather = WeatherData(
      resultCode: response.statusCode,
      longitude: response.statusCode == 200 ? double.parse(decodedJson['coord']['lon'].toString()) : -999,
      latitude: response.statusCode == 200 ? double.parse(decodedJson['coord']['lat'].toString()) : -999,
      weatherID: response.statusCode == 200 ? int.parse(decodedJson['weather'][0]['id'].toString()) : -999,
      weatherMain: response.statusCode == 200 ? decodedJson['weather'][0]['main'] : 'null',
      weatherDesc: response.statusCode == 200 ? decodedJson['weather'][0]['description'] : 'null',
      temp: response.statusCode == 200 ? double.parse(decodedJson['main']['temp'].toString()) : -999,
      feelsLike: response.statusCode == 200 ? double.parse(decodedJson['main']['feels_like'].toString()) : -999,
      tempMin: response.statusCode == 200 ?  double.parse(decodedJson['main']['temp_min'].toString()) : -999,
      tempMax: response.statusCode == 200 ? double.parse(decodedJson['main']['temp_max'].toString()) : -999,
      pressure: response.statusCode == 200 ? int.parse(decodedJson['main']['pressure'].toString()) : -999,
      humidity: response.statusCode == 200 ? int.parse(decodedJson['main']['humidity'].toString()) : -999,
      visibility: response.statusCode == 200 ? int.parse(decodedJson['visibility'].toString()) : -999,
      windSpeed: response.statusCode == 200 ? double.parse(decodedJson['wind']['speed'].toString()) : -999,
      countryCode: response.statusCode == 200 ? decodedJson['sys']['country'] : 'null',
      placeName: response.statusCode == 200 ? decodedJson['name'] : 'null'
      );
    return weather;
  }

}