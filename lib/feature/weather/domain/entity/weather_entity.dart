class WeatherEntity {
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

  WeatherEntity(
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

  double get temperatureCelsius {
    return (temperature - 273.15);
  }

  double get minTemperature {
    return (temMin - 273.15);
  }

  double get maxTemperature {
    return (temMax - 273.15);
  }

  double get feelsTemperature {
    return(feelsLike - 273.15);
  }

  String get minTemperatureRound {
    return '${minTemperature.round()}';
  }

  String get maxTemperatureRound {
    return '${maxTemperature.round()}';
  }

  String get feelsTemperatureRound {
    return '${feelsTemperature.round()}°';
  }

  String get temperatureRound {
    return '${temperatureCelsius.round()}°';
  }
}
