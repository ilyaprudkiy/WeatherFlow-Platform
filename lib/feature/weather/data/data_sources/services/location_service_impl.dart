import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/weather/data/models/location_model.dart';

import 'location_service.dart';

class LocationServiceImpl implements LocationService {
  @override
  Future<LocationModel> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }
    final Position position = await Geolocator.getCurrentPosition();

    return LocationModel(lat: position.latitude, lon: position.longitude);
  }
}
