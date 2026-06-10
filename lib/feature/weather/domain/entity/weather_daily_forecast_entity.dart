import '../../data/models/weather_daily_forecast_model.dart';

class WeatherDailyForecastEntity {
  final String timezone;
  final List<WeatherDailyItem> days;

  WeatherDailyForecastEntity({
    required this.timezone,
    required this.days,
  });
}
