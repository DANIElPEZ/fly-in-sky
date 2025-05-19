import 'package:flutter/material.dart';
import 'package:weatherfly/color/colors.dart';
import 'package:weatherfly/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:weatherfly/views/weather.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    provider.checkConnection();
  }

  int indexView = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: NavigationBar(
          animationDuration: Duration(milliseconds: 500),
          backgroundColor: colorsPalette['input'],
          selectedIndex: indexView,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (int index) {
            setState(() => indexView = index);
          },
          destinations: [
            NavigationDestination(icon: Icon(indexView==0?Icons.air:Icons.air_outlined, size: 34, color: indexView==0?colorsPalette['title']:colorsPalette['content']), label: ''),
            NavigationDestination(icon: Icon(indexView==1?Icons.checklist_rtl:Icons.checklist_rtl_outlined, size: 34, color: indexView==1?colorsPalette['title']:colorsPalette['content']), label: '')
          ],
        ),
        body: [WeatherView(), Container()][indexView]
      ),
    );
  }
}
