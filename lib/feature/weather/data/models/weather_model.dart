import 'package:weather_app/feature/weather/domain/entity/weather_entity.dart';

class WeatherModel {
  final String cityName;
  final String country;
  final String weatherMain;
  final String description;
  final String iconCode;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int cloudiness;
  final double? rainLastHour;
  final int pressure;
  final int visibility;
  final int sunrise;
  final int sunset;
  final double lat;
  final double lon;
  final double temMax;
  final double temMin;

  const WeatherModel(
      {required this.cityName,
      required this.country,
      required this.weatherMain,
      required this.description,
      required this.iconCode,
      required this.temperature,
      required this.feelsLike,
      required this.humidity,
      required this.windSpeed,
      required this.cloudiness,
      required this.rainLastHour,
      required this.pressure,
      required this.visibility,
      required this.sunrise,
      required this.sunset,
      required this.lat,
      required this.lon,
      required this.temMax,
      required this.temMin});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weatherList = json['weather'] as List?;
    final sys = json['sys'] as Map<String, dynamic>?;

    return WeatherModel(
      cityName: json['name'] ?? '',
      country: sys?['country'] ?? '',
      weatherMain: weatherList != null && weatherList.isNotEmpty
          ? weatherList[0]['main'] ?? ''
          : '',
      description: weatherList != null && weatherList.isNotEmpty
          ? weatherList[0]['description'] ?? ''
          : '',
      iconCode: weatherList != null && weatherList.isNotEmpty
          ? weatherList[0]['icon'] ?? ''
          : '',
      temperature: (json['main']?['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (json['main']?['feels_like'] as num?)?.toDouble() ?? 0.0,
      humidity: json['main']?['humidity'] ?? 0,
      windSpeed: (json['wind']?['speed'] as num?)?.toDouble() ?? 0.0,
      cloudiness: json['clouds']?['all'] ?? 0,
      rainLastHour: (json['rain']?['1h'] as num?)?.toDouble() ?? 0.0,
      pressure: json['main']?['pressure'] ?? 0,
      visibility: json['visibility'] ?? 0,
      sunrise: sys?['sunrise'] ?? 0,
      sunset: sys?['sunset'] ?? 0,
      lat: (json['coord']?['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['coord']?['lon'] as num?)?.toDouble() ?? 0.0,
      temMax: (json['main']?['temp_max'] as num?)?.toDouble() ?? 0.0,
      temMin: (json['main']?['temp_min'] as num?)?.toDouble() ?? 0.0,
    );
  }

  WeatherEntity toEntity() {
    return WeatherEntity(
        cityName: cityName,
        country: country,
        weatherMain: weatherMain,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        feelsLike: feelsLike,
        humidity: humidity,
        windSpeed: windSpeed,
        cloudiness: cloudiness,
        rainLastHour: rainLastHour,
        pressure: pressure,
        visibility: visibility,
        sunrise: sunrise,
        sunset: sunset,
        lat: lat,
        lon: lon,
        temMax: temMax,
        temMin: temMin);
  }
}
