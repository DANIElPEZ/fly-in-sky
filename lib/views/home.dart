import 'package:flutter/material.dart';
import 'package:flyinsky/color/colors.dart';
import 'package:flyinsky/views/weather.dart';
import 'package:flyinsky/views/checklist.dart';
import 'package:flyinsky/views/charts.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
            NavigationDestination(icon: Icon(indexView==0?Icons.cloud:Icons.cloud_outlined, size: 34, color: indexView==0?colorsPalette['title']:colorsPalette['content']), label: ''),
            NavigationDestination(icon: Icon(Icons.checklist, size: 34, color: indexView==1?colorsPalette['title']:colorsPalette['content']), label: ''),
            NavigationDestination(icon: Icon(indexView==2?Icons.map:Icons.map_outlined, size: 34, color: indexView==2?colorsPalette['title']:colorsPalette['content']), label: '')
          ],
        ),
        body: [WeatherView(), CheclistView(), ChartView()][indexView]
      ),
    );
  }
}
