import '../../data/models/weather_hours_model.dart';

class WeatherHoursEntity {
  final String timezone;
  final int timezoneOffset;
  final List<WeatherHourItem> hours;

  WeatherHoursEntity({
    required this.timezone,
    required this.timezoneOffset,
    required this.hours,
  });
}
