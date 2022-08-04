import 'package:geolocator/geolocator.dart';

class Location {
  late double longitude;
  late double latitude;

  Future getCurrentLocation() {
    Geolocator.requestPermission();
    try {
      return Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low)
          .then((value) {
        this.longitude = value.longitude;
        this.latitude = value.latitude;
      });
    } catch (e) {
      return new Future(() => {});
    }
  }
}
