class Configuration {
  static const String apiKey = '4547edf8a3e4e65f3b6dadaaa4831fdb';

  static String hostGeo({
    required double lat,
    required double lon,
  }) =>
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey';
  static const String anonKey =
      'sb_publishable_fDgWW7zxCoJaP44W3AAV1Q_1n3oSw1Y';
  static const String urlSupabase = 'https://ijqugaqrpljhmilinlol.supabase.co';

  static String hostCity({required String city}) =>
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

  static String weatherHours({required double lat, required double lon}) =>
      'https://api.openweathermap.org/data/4.0/onecall/timeline/1h?lat=$lat&lon=$lon&appid=$apiKey';

  static String weatherDaily({required double lat, required double lon}) =>
      'https://api.openweathermap.org/data/4.0/onecall/timeline/1day?lat=$lat&lon=$lon.4050&appid=$apiKey';
}
