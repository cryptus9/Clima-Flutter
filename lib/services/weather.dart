import '../apiKey.dart';
import 'location.dart';
import 'networking.dart';

class WeatherModel {

  // https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

  String _authority = 'api.openweathermap.org';
  String _path = '/data/2.5/weather';


  Future<WeatherData> getWeatherDataByCityName(String cityName) {
    Uri uri = Uri.https(this._authority, this._path, {
      'q': '$cityName',
      'units': 'metric',
      'appid': '$API_KEY'
    });
    return new NetworkHelper().getWeatherDataByUrl(uri);
  }

  Future<WeatherData> getWeatherOfCurrentLocation() async {
    Location location = new Location();
    await location.getCurrentLocation();
    Uri uri = Uri.https(this._authority, this._path, {
      'lat': '${location.latitude}',
      'lon': '${location.longitude}',
      'units': 'metric',
      'appid': '$API_KEY'
    });
    return new NetworkHelper().getWeatherDataByUrl(uri);
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
