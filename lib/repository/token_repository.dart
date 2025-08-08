import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flyinsky/sqlite/sql_helper.dart';

class TokenRepository {
  Future<void> authVatsim() async {
    final String authUrl = dotenv.env['AUTH'] ?? '';
    final String clientId = dotenv.env['CLIENT_ID'] ?? '';
    final String scopes = dotenv.env['SCOPES'] ?? '';
    final String redirectUri = dotenv.env['REDIRECT_URL'] ?? '';

    final url =
        "$authUrl?client_id=$clientId&redirect_uri=$redirectUri&response_type=code&scope=${Uri.encodeComponent(scopes)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir el navegador.';
    }
  }

  Future<Map<String,dynamic>> getAccessToken(String code) async {
    final String tokenUrl = dotenv.env['ACCESS_TOKEN'] ?? '';
    final String clientId = dotenv.env['CLIENT_ID'] ?? '';
    final String clientSecret = dotenv.env['CLIENT_SECRET'] ?? '';
    final String redirectUri = dotenv.env['REDIRECT_URL'] ?? '';

    try {
      final response = await http.post(
        Uri.parse(tokenUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': redirectUri,
          'client_id': clientId,
          'client_secret': clientSecret,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final accessToken = data['access_token'];
        return {'token': accessToken, 'expires_in': data['expires_in']};
      }
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<String> getToken()async{
    final token=await DatabaseHelper().getToken();
    return token['token'];
  }

  Future<void> saveToken(Map<String, dynamic> token)async {
    final db=DatabaseHelper();
    final accessToken=token['token'];
    final expiresDate=token['expires_in'];
    await db.saveToken(accessToken, expiresDate);
  }
}
