import 'package:weather_app/feature/weather/domain/entity/weather_entity.dart';

enum CityCardKind { currentLocation, recent, popular }

class CityWeatherCardEntity {
  final String id;
  final String title;
  final String subtitle;
  final String temperatureLabel;
  final String weatherDescription;
  final String iconCode;
  final CityCardKind kind;
  final String cityName;
  final double lat;
  final double lon;

  const CityWeatherCardEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.temperatureLabel,
    required this.weatherDescription,
    required this.iconCode,
    required this.kind,
    required this.cityName,
    required this.lat,
    required this.lon,
  });

  factory CityWeatherCardEntity.fromWeather(
    WeatherEntity weather, {
    required CityCardKind kind,
    String? title,
  }) {
    final description = weather.description.isNotEmpty
        ? '${weather.description[0].toUpperCase()}${weather.description.substring(1)}'
        : weather.weatherMain;

    return CityWeatherCardEntity(
      id: '${weather.cityName}_${weather.country}_${kind.name}',
      title: title ?? weather.cityName,
      subtitle: '${weather.cityName}, ${weather.country}',
      temperatureLabel: weather.temperatureRound,
      weatherDescription: description,
      iconCode: weather.iconCode,
      kind: kind,
      cityName: weather.cityName,
      lat: weather.lat,
      lon: weather.lon,
    );
  }

  bool matchesQuery(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return true;

    return title.toLowerCase().contains(normalized) ||
        subtitle.toLowerCase().contains(normalized) ||
        cityName.toLowerCase().contains(normalized);
  }
}

class CitySearchSnapshot {
  final CityWeatherCardEntity? locationCard;
  final List<CityWeatherCardEntity> recentCards;
  final List<CityWeatherCardEntity> popularCards;

  const CitySearchSnapshot({
    required this.locationCard,
    required this.recentCards,
    required this.popularCards,
  });

  static const empty = CitySearchSnapshot(
    locationCard: null,
    recentCards: [],
    popularCards: [],
  );
}
