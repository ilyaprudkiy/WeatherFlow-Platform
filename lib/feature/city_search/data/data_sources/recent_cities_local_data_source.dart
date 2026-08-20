class RecentCitiesLocalDataSource {
  static const defaultCities = [
    'Moscow',
    'Saint Petersburg',
    'Sochi',
  ];

  static const popularCities = [
    'London',
    'Paris',
    'Dubai',
    'Tokyo',
    'New York',
  ];

  final List<String> _recentCities = List.from(defaultCities);

  List<String> getRecentCities() => List.unmodifiable(_recentCities);

  void clearRecentCities() => _recentCities.clear();

  void rememberCity(String cityName) {
    _recentCities.remove(cityName);
    _recentCities.insert(0, cityName);
    if (_recentCities.length > 5) {
      _recentCities.removeRange(5, _recentCities.length);
    }
  }
}
