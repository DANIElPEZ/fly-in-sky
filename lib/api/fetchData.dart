import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> get_weather_information(String icao_id) async {
  try {
    final response = await http.get(
      Uri.parse(
        'https://aviationweather.gov/api/data/metar?ids=$icao_id&format=json',
      )
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching weather data: $e');
  }
}
