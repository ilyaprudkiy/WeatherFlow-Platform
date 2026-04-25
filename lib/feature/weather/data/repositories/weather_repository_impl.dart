import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/mappers/weather_error_mapper.dart';
import 'package:weather_app/feature/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/feature/weather/domain/repository/weather_repository.dart';
import '../../../../core/error/failure/failure.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource dataSource;
  final WeatherErrorMapper errorMapper;

  WeatherRepositoryImpl(this.dataSource, this.errorMapper);

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherByCityName(String city) async {
    try {
      final weatherModel = await dataSource.getWeatherDataByCityName(city);
      return Right(weatherModel.toEntity());
    } catch (e) {
      return Left(errorMapper.map(e, context: 'WeatherForCity'));
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherByGeo(
      double lat, double lon) async {
    try {
      final weatherModel = await dataSource.getWeatherDataByGeo(lat, lon);
      return Right(weatherModel.toEntity());
    } catch (e) {
      return Left(errorMapper.map(e, context: 'WeatherForCity'));
    }
  }
}
