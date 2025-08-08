abstract class chartsEvent {}

class setIcao extends chartsEvent{
  final String icao;
  setIcao(this.icao);
}

class loadCharts extends chartsEvent{}

class setUrlChart extends chartsEvent{
  final String idChart;
  setUrlChart(this.idChart);
}