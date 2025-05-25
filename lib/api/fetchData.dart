import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> get_weather_information(String icao_id) async {
  try {
    print(icao_id);
    final response = await http.get(
      Uri.parse(
        'https://aviationweather.gov/api/data/metar?ids=$icao_id&format=json',
      )
    );
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  } catch (e) {
    print(e);
    return [];
  }
}
