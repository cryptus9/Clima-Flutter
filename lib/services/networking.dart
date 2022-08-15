import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;

import '../apiKey.dart';

class NetworkHelper {
  Future<WeatherData> getWeatherOfCurrentLocation() async {

    Location location = new Location();
    await location.getCurrentLocation();
    print('got location ${location.latitude}');
    Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'lat': '${location.latitude}', 'lon': '${location.longitude}', 'units': 'metric', 'appid': '$API_KEY'});
    return http.get(uri).then((response) {
      if (response.statusCode == 200) {
        return mapResponseToData(response);
      } else {
        print(response.statusCode);
        return new WeatherData(locationName: 'test', condition: 1, temperature: 1);
      }
    });
  }

  WeatherData mapResponseToData(http.Response response) {
    var data = jsonDecode(response.body);
    double temp = data['main']['temp'];
    String location = data['name'];
    int condition = data['weather'][0]['id'];
    return new WeatherData(
      condition: condition,
      locationName: location,
      temperature: temp.toInt(),
    );
  }
}

class WeatherData {
  String locationName;
  int condition;
  int temperature;

  WeatherData({
    required this.locationName,
    required this.condition,
    required this.temperature,
  });
}
