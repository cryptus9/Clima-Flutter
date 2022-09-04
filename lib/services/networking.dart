import 'dart:convert';

import 'package:http/http.dart' as http;


class NetworkHelper {

  Future<WeatherData> getWeatherDataByUrl(Uri uri) {
    return http.get(uri).then((response) {
      if (response.statusCode == 200) {
        return _mapResponseToData(response);
      } else {
        return new WeatherData(locationName: 'test', condition: 1, temperature: 1);
      }
    });
  }

  WeatherData _mapResponseToData(http.Response response) {
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
