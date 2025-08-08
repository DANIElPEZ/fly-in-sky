abstract class WeatherEvent{}

class setIcao extends WeatherEvent{
  final String icao;
  setIcao(this.icao);
}

class loadWeather extends WeatherEvent{}