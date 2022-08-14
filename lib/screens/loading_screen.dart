import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    NetworkHelper networkHelper = new NetworkHelper();
    networkHelper.getWeatherData(location).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.grey,
          size: 100,
        ),
      ),
    );
  }
}
