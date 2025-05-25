import 'package:flutter/material.dart';
import 'package:flyinsky/color/colors.dart';
import 'package:flyinsky/components/input_text_weather.dart';
import 'package:flyinsky/components/airport_info_weather.dart';
import 'package:flyinsky/components/card_metar_weather.dart';
import 'package:flyinsky/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:flyinsky/components/appBar.dart';

class WeatherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(input: InputText()),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: colorsPalette['light blue'],
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.getConnection) {
                  if(provider.isLoading){
                    return loading(context);
                  }else{
                    final data=provider.data;

                    if (data.isEmpty) {
                      return loading(context);
                    }

                    final ICAO=data[0]['icaoId'];
                    final Name=data[0]['name'];
                    final altitude=data[0]['elev']*3.281.truncate();
                    return Column(
                      children: [
                        AirportInfo(
                          Name: Name,
                          ICAO: ICAO,
                          altitude: altitude.toString(),
                        ),
                        SizedBox(height: 20),
                        Expanded(child: CardMetar(data: data))
                      ],
                    );
                  }
                }else{
                  return loading(context);
                }
              }
          ),
        ),
      ),
    );
  }

  Widget loading(BuildContext context){
    return Column(
      children: [
        AirportInfo(
          Name: 'AAAAA/AAAAA AAAA, AA, AA',
          ICAO: 'AAAA',
          altitude: '0000',
        ),
        SizedBox(height: 20),
        Expanded(child: CardMetar(data: []))
      ],
    );
  }
}
