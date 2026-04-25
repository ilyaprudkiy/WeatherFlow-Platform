import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure/failure.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/feature/weather/domain/repository/weather_repository.dart';

class WeatherUseCase {
  final WeatherRepository repository;

  WeatherUseCase(this.repository);

  Future<Either<Failure, WeatherEntity>> getWeatherByCityName(String city) {
    return repository.getWeatherByCityName(city);
  }

  Future<Either<Failure, WeatherEntity>> getWeatherByGeo(
      double lat, double lon) {
    return repository.getWeatherByGeo(lat, lon);
  }
}
