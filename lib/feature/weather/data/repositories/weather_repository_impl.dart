import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/mappers/weather_error_mapper.dart';
import 'package:weather_app/feature/weather/data/data_sources/services/default_city_service.dart';
import 'package:weather_app/feature/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/feature/weather/data/models/location_model.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_hours_entity.dart';
import 'package:weather_app/feature/weather/domain/repository/weather_repository.dart';
import '../../../../core/error/failure/failure.dart';
import '../../domain/entity/weather_daily_forecast_entity.dart';
import '../data_sources/services/location_service.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource dataSource;
  final WeatherErrorMapper errorMapper;
  final LocationService locationService;
  final DefaultCityService defaultCityService;

  WeatherRepositoryImpl(this.dataSource, this.errorMapper, this.locationService,
      this.defaultCityService);

  @override
  Future<Either<Failure, WeatherEntity>> getDefaultCityWeather() async {
    final defaultCity = defaultCityService.getDefaultCity();
    try {
      final weatherModel =
          await dataSource.getWeatherDataByCityName(defaultCity);
      return Right(weatherModel.toEntity());
    } catch (e) {
      return Left(errorMapper.map(e,
          context: 'WeatherRepository.getDefaultCityWeather'));
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherByCityName(
      String city) async {
    try {
      final weatherModel = await dataSource.getWeatherDataByCityName(city);
      return Right(weatherModel.toEntity());
    } catch (e) {
      return Left(errorMapper.map(e, context: 'WeatherForCity'));
    }
  }

  @override
  Future<Either<Failure, LocationModel>> getCords() async {
    try {
      final location = await locationService.getCurrentLocation();
      return Right(location);
    } catch (e) {
      return Left(errorMapper.map(e, context: 'WeatherCubit.getPosition'));
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherByGeo() async {
    try {
      final cordsResult = await getCords();
      return cordsResult.fold(
        (failure) async => Left(failure),
        (cords) async {
          final weatherModel =
              await dataSource.getWeatherDataByGeo(cords.lat, cords.lon);
          return Right(weatherModel.toEntity());
        },
      );
    } catch (e) {
      return Left(errorMapper.map(e, context: 'WeatherForCity'));
    }
  }

  @override
  Future<Either<Failure, WeatherHoursEntity>> getWeatherHours(
      double lat, double lon) async {
    try {
      final result = await dataSource.getWeatherHours(lat, lon);
      return Right(result.toEntity());
    } catch (e) {
      return Left(errorMapper.map(e, context: 'GetWeatherHours'));
    }
  }

  @override
  Future<Either<Failure, WeatherDailyForecastEntity>> getWeatherDaily(
      double lat, double lon) async {
    try {
      final result = await dataSource.getWeatherDaily(lat, lon);
      return Right(result.toEntity());
    } catch (e) {
      return Left(errorMapper.map(e, context: 'GetWeatherDaily'));
    }
  }
}
