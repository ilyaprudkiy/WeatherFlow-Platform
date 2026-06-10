import 'dart:ui';

class DefaultCityService {
  Map<String, String> cityByLanguage = {
    'de': 'Berlin',
    'ua': 'Kyiv',
    'pl': 'Warsaw',
    'fr': 'Paris',
    'it': 'Rome',
    'es': 'Madrid',
    'gb': 'London',
    'us': 'New York'
  };

  Map<String, String> cityByCountry = {
    'DE': 'Berlin',
    'UA': 'Kyiv',
    'PL': 'Warsaw',
    'FR': 'Paris',
    'IT': 'Rome',
    'ES': 'Madrid',
    'GB': 'London',
    'US': 'New York',
  };

  String getDefaultCity() {
    final locale = PlatformDispatcher.instance.locale;

    final countyCode = locale.countryCode?.toUpperCase();
    final languageCode = locale.languageCode.toLowerCase();
    if (countyCode != null) {
      return cityByCountry[countyCode]!;
    }
    if (languageCode.contains(languageCode)) {
      return cityByLanguage[countyCode]!;
    }
    final timeZoneCity = _getCityByTimezone();
    if (timeZoneCity != null) {
      return timeZoneCity;
    }
    return 'Berlin';
  }

  String? _getCityByTimezone() {
    final offset = DateTime.now().timeZoneOffset.inHours;
    switch (offset) {
      case 0:
        return 'London';
      case 1:
      case 2:
        return 'Berlin';
      case 3:
        return 'Kyiv';
      default:
        return null;
    }
  }
}
