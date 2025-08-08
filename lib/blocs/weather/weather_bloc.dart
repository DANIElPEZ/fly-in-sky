import 'package:flyinsky/blocs/weather/weather_event.dart';
import 'package:flyinsky/blocs/weather/weather_state.dart';
import 'package:flyinsky/repository/weather_repository.dart';
import 'package:bloc/bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherState.initial()) {
    on<setIcao>((event, emit) {
      emit(state.copyWith(icao: event.icao));
    });
    on<loadWeather>((event, emit) async {
      try {
        final data = await weatherRepository.getWeather(state.icao);
        emit(state.copyWith(data: data));
      }catch(e){
        print(e);
      }
    });
  }
}
