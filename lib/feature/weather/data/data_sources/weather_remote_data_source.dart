import 'package:weather_app/feature/weather/data/models/weather_daily_forecast_model.dart';
import 'package:weather_app/feature/weather/data/models/weather_hours_model.dart';
import 'package:weather_app/feature/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherDataByCityName(String city);

  Future<WeatherDailyForecastModel> getWeatherDaily(double lat, double lon);

  Future<WeatherHoursModel> getWeatherHours(double lat, double lon);

  Future<WeatherModel> getWeatherDataByGeo(double lat, double lon);
}
