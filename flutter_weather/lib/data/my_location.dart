import 'package:geolocator/geolocator.dart';

class MyLocation {
  double latitude, longtitude;

  Future<void> getMyCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longtitude = position.longitude;
    } catch (e) {
      print('Network Connection Error');
    }
  }
}
