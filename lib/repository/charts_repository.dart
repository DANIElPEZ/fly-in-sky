import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChartsRepository{
  Future<List<Map<String, String>>> getGroupedCharts(accessToken, icao) async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['API_BASIC_ROUTE']}airports/$icao/charts/grouped'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final data = json['data'] as Map<String, dynamic>;
        final List<Map<String, String>> extractedCharts = [];

        data.forEach((principalId, items) {
          for (final item in items) {
            extractedCharts.add({
              'id': principalId,
              'name': item['name'],
              'chart_id': item['id'],
              'chart_type': item['type_key'],
            });
          }
        });
        print(extractedCharts);

        return extractedCharts;
      }
    }catch(e){
      print('Error: $e');
    }
    return [];
  }

  Future<String> getChart(accessToken, idChart) async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['API_BASIC_ROUTE']}charts/$idChart'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return json['source_url'];
      }
    }catch(e){
      print('Error: $e');
    }
    return '';
  }
}