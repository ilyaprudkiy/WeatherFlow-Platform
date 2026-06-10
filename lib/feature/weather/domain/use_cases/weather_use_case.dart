import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure/failure.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_daily_forecast_entity.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_hours_entity.dart';
import 'package:weather_app/feature/weather/domain/repository/weather_repository.dart';

class WeatherUseCase {
  final WeatherRepository repository;

  WeatherUseCase(this.repository);

  Future<Either<Failure, WeatherEntity>> getWeatherByCityName(String city) {
    return repository.getWeatherByCityName(city);
  }

  Future<Either<Failure, WeatherEntity>> getWeatherByGeo() {
    return repository.getWeatherByGeo();
  }

  Future<Either<Failure, WeatherEntity>> getDefaultCityWeather() {
    return repository.getDefaultCityWeather();
  }

  Future<Either<Failure, WeatherHoursEntity>> getWeatherHours(
      double lat, double lon) {
    return repository.getWeatherHours(lat, lon);
  }

  Future<Either<Failure, WeatherDailyForecastEntity>> getWeatherDaily(
      double lat, double lon) {
    return repository.getWeatherDaily(lat, lon);
  }
}
