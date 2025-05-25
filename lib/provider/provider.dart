import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../api/fetchData.dart';

class WeatherProvider extends ChangeNotifier {
  List<dynamic> data=[];
  bool isLoading = true;
  bool getConnection = false;

  Future<void> checkConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      getConnection = (connectivityResult[0] == ConnectivityResult.mobile ||
          connectivityResult[0] == ConnectivityResult.wifi);
    } catch (e) {
      getConnection = false;
    }
    notifyListeners();
  }

  Future<void> fetchWeather(String icao) async {
    isLoading = true;
    checkConnection();
    notifyListeners();
    if (!getConnection){
      isLoading = false;
      notifyListeners();
      return;
    }
    data = await get_weather_information(icao);
    print(data);
    isLoading = false;
    notifyListeners();
  }
}