import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyinsky/views/splash.dart';
import 'package:provider/provider.dart';
import 'package:flyinsky/provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(
      ChangeNotifierProvider(
          create: (_)=>WeatherProvider(),
      child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashPage()
    );
  }
}