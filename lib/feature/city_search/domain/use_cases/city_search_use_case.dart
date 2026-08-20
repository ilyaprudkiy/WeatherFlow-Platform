import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure/failure.dart';
import 'package:weather_app/feature/city_search/domain/entity/city_weather_card_entity.dart';
import 'package:weather_app/feature/city_search/domain/repository/city_search_repository.dart';

class CitySearchUseCase {
  final CitySearchRepository repository;

  CitySearchUseCase(this.repository);

  Future<Either<Failure, CitySearchSnapshot>> loadSearchSnapshot() {
    return repository.loadSearchSnapshot();
  }

  Future<Either<Failure, Unit>> clearRecentCities() {
    return repository.clearRecentCities();
  }

  Future<Either<Failure, Unit>> rememberRecentCity(String cityName) {
    return repository.rememberRecentCity(cityName);
  }
}
