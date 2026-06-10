import 'package:dartz/dartz.dart';
import 'package:weather_app/feature/weather/data/models/location_model.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_daily_forecast_entity.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_hours_entity.dart';
import '../../../../core/error/failure/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeatherByCityName(String city);

  Future<Either<Failure, WeatherEntity>> getWeatherByGeo();

  Future<Either<Failure, LocationModel>> getCords();

  Future<Either<Failure, WeatherEntity>> getDefaultCityWeather();

  Future<Either<Failure, WeatherHoursEntity>> getWeatherHours(
      double lat, double lon);

  Future<Either<Failure, WeatherDailyForecastEntity>> getWeatherDaily(
      double lat, double lon);
}
