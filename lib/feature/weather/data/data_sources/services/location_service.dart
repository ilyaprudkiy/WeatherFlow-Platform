import 'package:weather_app/feature/weather/data/models/location_model.dart';

abstract class LocationService {
  Future<LocationModel> getCurrentLocation();
}
