class WeatherState {
  WeatherState({required this.icao, this.data});

  final String icao;
  List<dynamic>? data;

  factory WeatherState.initial(){
    return WeatherState(icao: '', data: []);
  }

  WeatherState copyWith({String? icao, List<dynamic>? data}){
    return WeatherState(
      icao: icao ?? this.icao,
      data: data ?? this.data,
    );
  }
}
