import 'dart:async';
import 'package:flyinsky/blocs/charts/chart_state.dart';
import 'package:flyinsky/blocs/charts/chart_event.dart';
import 'package:flyinsky/repository/charts_repository.dart';
import 'package:flyinsky/blocs/token/token_bloc.dart';
import 'package:bloc/bloc.dart';

class chartsBloc extends Bloc<chartsEvent, chartsState>{
  final ChartsRepository chartsrepository;
  late final StreamSubscription tokenSubscription;
  final TokenBloc tokenBloc;
  String token='';

  chartsBloc({required this.tokenBloc, required this.chartsrepository}):super(chartsState.initial()){
    token=tokenBloc.state.tokenAccess;

    on<setIcao>((event, emit){
      emit(state.copyWith(icao: event.icao));
    });
    on<loadCharts>((event, emit)async{
      try {
        final charts = await chartsrepository.getGroupedCharts(token, state.icao);
        emit(state.copyWith(charts: charts));
      }catch(e){
        print(e);
      }
    });
    on<loadPdfChart>((event, emit)async{
      try{
        final url=await chartsrepository.getChart(token, event.idChart);//send from id from clicking ui
        emit(state.copyWith(urlChart: url));
      }catch(e){
        print(e);
      }
    });
  }

  @override
  Future<void> close() {
    tokenSubscription.cancel();
    return super.close();
  }
}