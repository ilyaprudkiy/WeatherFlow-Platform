import 'package:weather_app/feature/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherDataByCityName(String city);

  Future<WeatherModel> getWeatherDataByGeo(double lat, double lon);
}
