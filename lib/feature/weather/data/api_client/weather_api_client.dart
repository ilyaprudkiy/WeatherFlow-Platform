import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:weather_app/core/config/configuration/configuration.dart';
import 'package:weather_app/feature/weather/data/models/weather_model.dart';



class WeatherApiClient {
  Future<WeatherModel> getWeatherDataCityName(String city) async {
    try {
      final url = Uri.parse(Configuration.hostCity(city: city));
      final res = await http.get(url);
      if (res.statusCode == 200) {
        return WeatherModel.fromJson(
            convert.jsonDecode(res.body) as Map<String, dynamic>);
      } else {
        throw Exception('Status code: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<WeatherModel> getWeatherDataGeo(double lat, double lon) async {
    try {
      final url = Uri.parse(Configuration.hostGeo(lat: lat, lon: lon));
      final res = await http.get(url);
      if (res.statusCode == 200) {
        return WeatherModel.fromJson(
            convert.jsonDecode(res.body) as Map<String, dynamic>);
      } else {
        throw Exception('StatusCode: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
