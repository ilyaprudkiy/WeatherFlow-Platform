import 'package:dartz/dartz.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_entity.dart';
import '../../../../core/error/failure/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeatherByCityName(String city);

  Future<Either<Failure, WeatherEntity>> getWeatherByGeo(
      double lat, double lon);
}
