import 'package:weather_app/feature/weather/data/api_client/weather_api_client.dart';
import 'package:weather_app/feature/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/feature/weather/data/models/weather_daily_forecast_model.dart';
import 'package:weather_app/feature/weather/data/models/weather_hours_model.dart';
import 'package:weather_app/feature/weather/data/models/weather_model.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final WeatherApiClient _apiClient;

  WeatherRemoteDataSourceImpl(this._apiClient);

  @override
  Future<WeatherModel> getWeatherDataByCityName(String city) async {
    final weatherModel = await _apiClient.getWeatherDataCityName(city);
    return weatherModel;
  }

  @override
  Future<WeatherModel> getWeatherDataByGeo(double lat, double lon) async {
    final weatherModel = await _apiClient.getWeatherDataGeo(lat, lon);
    return weatherModel;
  }

  @override
  Future<WeatherDailyForecastModel> getWeatherDaily(
      double lat, double lon) async {
    final model = await _apiClient.getWeatherDays(lat, lon);
    return model;
  }

  @override
  Future<WeatherHoursModel> getWeatherHours(double lat, double lon) async {
    final model = await _apiClient.getWeatherHours(lat, lon);
    return model;
  }
}
