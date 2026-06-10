import 'package:weather_app/feature/weather/domain/entity/weather_hours_entity.dart';

class WeatherHoursModel {
  final String timezone;
  final int timezoneOffset;
  final List<WeatherHourItem> hours;

  const WeatherHoursModel({
    required this.timezone,
    required this.timezoneOffset,
    required this.hours,
  });

  factory WeatherHoursModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List? ?? [];

    return WeatherHoursModel(
      timezone: json['timezone'] ?? '',
      timezoneOffset: json['timezone_offset'] ?? 0,
      hours: data.take(24).map((hour) {
        return WeatherHourItem.fromJson(hour as Map<String, dynamic>);
      }).toList(),
    );
  }

  WeatherHoursEntity toEntity() {
    return WeatherHoursEntity(
        timezone: timezone, timezoneOffset: timezoneOffset, hours: hours);
  }
}

class WeatherHourItem {
  final int dataTime;
  final double temperature;
  final double feelsLike;
  final String iconCode;

  const WeatherHourItem({
    required this.dataTime,
    required this.temperature,
    required this.feelsLike,
    required this.iconCode,
  });

  factory WeatherHourItem.fromJson(Map<String, dynamic> json) {
    final weatherList = json['weather'] as List?;
    final weather = weatherList != null && weatherList.isNotEmpty
        ? weatherList.first as Map<String, dynamic>
        : null;

    return WeatherHourItem(
      dataTime: json['dt'] ?? 0,
      temperature: (json['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (json['feels_like'] as num?)?.toDouble() ?? 0.0,
      iconCode: weather?['icon'] ?? '',
    );
  }
}
