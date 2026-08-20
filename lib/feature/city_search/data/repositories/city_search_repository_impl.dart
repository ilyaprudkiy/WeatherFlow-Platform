import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure/failure.dart';
import 'package:weather_app/core/error/mappers/weather_error_mapper.dart';
import 'package:weather_app/feature/city_search/data/data_sources/recent_cities_local_data_source.dart';
import 'package:weather_app/feature/city_search/domain/entity/city_weather_card_entity.dart';
import 'package:weather_app/feature/city_search/domain/repository/city_search_repository.dart';
import 'package:weather_app/feature/weather/domain/repository/weather_repository.dart';

class CitySearchRepositoryImpl implements CitySearchRepository {
  CitySearchRepositoryImpl(
    this._weatherRepository,
    this._recentCitiesLocalDataSource,
    this._weatherErrorMapper,
  );

  final WeatherRepository _weatherRepository;
  final RecentCitiesLocalDataSource _recentCitiesLocalDataSource;
  final WeatherErrorMapper _weatherErrorMapper;

  @override
  Future<Either<Failure, CitySearchSnapshot>> loadSearchSnapshot() async {
    try {
      final locationResult = await _weatherRepository.getWeatherByGeo();
      final recentNames = _recentCitiesLocalDataSource.getRecentCities();
      final popularNames = RecentCitiesLocalDataSource.popularCities;

      final recentCards = await _loadCityCards(
        recentNames,
        CityCardKind.recent,
      );
      final popularCards = await _loadCityCards(
        popularNames,
        CityCardKind.popular,
      );

      CityWeatherCardEntity? locationCard;
      locationResult.fold(
        (_) => locationCard = null,
        (weather) => locationCard = CityWeatherCardEntity.fromWeather(
          weather,
          kind: CityCardKind.currentLocation,
          title: 'My location',
        ),
      );

      return Right(
        CitySearchSnapshot(
          locationCard: locationCard,
          recentCards: recentCards,
          popularCards: popularCards,
        ),
      );
    } catch (error) {
      return Left(_weatherErrorMapper.map(error));
    }
  }

  Future<List<CityWeatherCardEntity>> _loadCityCards(
    List<String> cityNames,
    CityCardKind kind,
  ) async {
    final cards = await Future.wait(
      cityNames.map((city) async {
        final result = await _weatherRepository.getWeatherByCityName(city);
        return result.fold<CityWeatherCardEntity?>(
          (_) => null,
          (weather) => CityWeatherCardEntity.fromWeather(weather, kind: kind),
        );
      }),
    );

    return cards.whereType<CityWeatherCardEntity>().toList();
  }

  @override
  Future<Either<Failure, Unit>> clearRecentCities() async {
    _recentCitiesLocalDataSource.clearRecentCities();
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> rememberRecentCity(String cityName) async {
    _recentCitiesLocalDataSource.rememberCity(cityName);
    return const Right(unit);
  }
}
