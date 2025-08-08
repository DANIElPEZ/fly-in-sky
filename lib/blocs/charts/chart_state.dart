class chartsState {
  final String icao;
  final List<Map<String, String>> charts;
  final String? urlChart;

  chartsState({required this.charts, this.urlChart, required this.icao});

  factory chartsState.initial() {
    return chartsState(icao:'',charts: [], urlChart: '');
  }

  chartsState copyWith({List<Map<String, String>>? charts, String? urlChart, String? icao}) {
    return chartsState(
      charts: charts ?? this.charts,
      urlChart: urlChart ?? this.urlChart,
      icao:  icao ?? this.icao
    );
  }
}
