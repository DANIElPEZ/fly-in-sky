import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRepository{
  Future<dynamic> getWeather(String icao) async {
    try {
      final response = await http.get(
          Uri.parse(
            'https://aviationweather.gov/api/data/metar?ids=$icao&format=json',
          )
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('error $e');
      return [];
    }
  }
}