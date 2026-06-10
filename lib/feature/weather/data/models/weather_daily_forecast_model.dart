import 'package:weather_app/feature/weather/domain/entity/weather_daily_forecast_entity.dart';

class WeatherDailyForecastModel {
  final String timezone;
  final List<WeatherDailyItem> days;

  WeatherDailyForecastModel({
    required this.timezone,
    required this.days,
  });

  factory WeatherDailyForecastModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>? ?? [];

    return WeatherDailyForecastModel(
      timezone: json['timezone'] ?? '',
      days:
      list.take(7).map((item) => WeatherDailyItem.fromJson(item)).toList(),
    );
  }

  WeatherDailyForecastEntity toEntity() {
    return WeatherDailyForecastEntity(timezone: timezone, days: days);
  }
}

class WeatherDailyItem {
  final DateTime date;
  final DateTime sunrise;
  final DateTime sunset;
  final double dayTemp;
  final double minTemp;
  final double maxTemp;
  final double nightTemp;
  final double feelsLikeDay;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final int clouds;
  final double rain;
  final String iconCode;
  final double uvi;

  WeatherDailyItem({
    required this.date,
    required this.sunrise,
    required this.sunset,
    required this.dayTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.nightTemp,
    required this.feelsLikeDay,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.clouds,
    required this.rain,
    required this.iconCode,
    required this.uvi,
  });

  double get minCelsius => _toCelsius(minTemp);
  double get maxCelsius => _toCelsius(maxTemp);

  String get minLabel => '${minCelsius.round()}°';
  String get maxLabel => '${maxCelsius.round()}°';

  static double _toCelsius(double value) {
    if (value > 150) return value - 273.15;
    return value;
  }

  factory WeatherDailyItem.fromJson(Map<String, dynamic> json) {
    final temp = json['temp'] as Map<String, dynamic>? ?? {};
    final feelsLike = json['feels_like'] as Map<String, dynamic>? ?? {};
    final weatherList = json['weather'] as List?;
    final weather = weatherList != null && weatherList.isNotEmpty
        ? weatherList.first as Map<String, dynamic>
        : null;

    return WeatherDailyItem(
      date: DateTime.fromMillisecondsSinceEpoch(
        (json['dt'] as int) * 1000,
      ),
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        (json['sunrise'] as int) * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        (json['sunset'] as int) * 1000,
      ),
      dayTemp: ((temp['day'] ?? 0) as num).toDouble(),
      minTemp: ((temp['min'] ?? 0) as num).toDouble(),
      maxTemp: ((temp['max'] ?? 0) as num).toDouble(),
      nightTemp: ((temp['night'] ?? 0) as num).toDouble(),
      feelsLikeDay: ((feelsLike['day'] ?? 0) as num).toDouble(),
      pressure: ((json['pressure'] ?? 0) as num).round(),
      humidity: ((json['humidity'] ?? 0) as num).round(),
      windSpeed: ((json['wind_speed'] ?? 0) as num).toDouble(),
      windDeg: ((json['wind_deg'] ?? 0) as num).round(),
      clouds: ((json['clouds'] ?? 0) as num).round(),
      rain: ((json['rain'] ?? 0) as num).toDouble(),
      iconCode: weather?['icon']?.toString() ?? '01d',
      uvi: ((json['uvi'] ?? 0) as num).toDouble(),
    );
  }
}
