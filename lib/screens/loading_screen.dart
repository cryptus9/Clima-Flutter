import 'package:clima/apiKey.dart';
import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Location location = new Location();
    location.getCurrentLocation().then((value) => {
          getWeatherData(location),
        });
  }

  void getWeatherData(Location location) {
    var lat = location.latitude;
    var lon = location.longitude;
    Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'lat': '$lat', 'lon': '$lon', 'appid': '$API_KEY'});
    print(uri);
    get(uri).then((value) => print(value.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
