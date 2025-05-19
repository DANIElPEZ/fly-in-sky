import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherfly/color/colors.dart';
import 'package:weatherfly/components/input_text.dart';
import 'package:weatherfly/components/airport_info.dart';
import 'package:weatherfly/components/card_metar.dart';
import 'package:weatherfly/provider/provider.dart';
import 'package:provider/provider.dart';

class WeatherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: colorsPalette['appbar'],
          title: Text(
            'Fly in sky',
            style: GoogleFonts.nunito(
              color: colorsPalette['title'],
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Icon(
            Icons.flight_takeoff,
            color: colorsPalette['title'],
            size: 30,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: InputText(),
            ),
          ),
        ),
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
                        //CardMetar(data: data)
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
       // CardMetar(data: [])
      ],
    );
  }
}
