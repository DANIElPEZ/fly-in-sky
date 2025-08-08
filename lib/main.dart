import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flyinsky/views/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyinsky/repository/weather_repository.dart';
import 'package:flyinsky/repository/charts_repository.dart';
import 'package:flyinsky/repository/token_repository.dart';
import 'package:flyinsky/blocs/weather/weather_bloc.dart';
import 'package:flyinsky/blocs/token/token_bloc.dart';
import 'package:flyinsky/blocs/charts/chart_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(Main());
  });
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherRepository>(
          create: (context) => WeatherRepository(),
        ),
        RepositoryProvider<ChartsRepository>(
          create: (context) => ChartsRepository(),
        ),
        RepositoryProvider<TokenRepository>(
          create: (context) => TokenRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TokenBloc>(
            create:
                (context) => TokenBloc(
                  tokenRepository: RepositoryProvider.of<TokenRepository>(
                    context,
                  ),
                ),
          ),
          BlocProvider<WeatherBloc>(
            create:
                (context) => WeatherBloc(
                  weatherRepository: RepositoryProvider.of<WeatherRepository>(
                    context,
                  ),
                ),
          ),
          BlocProvider<chartsBloc>(
            create: (context) {
              final tokenBloc = BlocProvider.of<TokenBloc>(context);
              final subscription = tokenBloc.stream.listen((event) {});
              final chartsrepository = RepositoryProvider.of<ChartsRepository>(context);

              return chartsBloc(
                tokenBloc: tokenBloc,
                chartsrepository: chartsrepository
              );
            }
          )
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: splashPage(),
            );
          },
        ),
      ),
    );
  }
}
