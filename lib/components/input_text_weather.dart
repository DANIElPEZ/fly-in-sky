import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flyinsky/color/colors.dart';
import 'package:flyinsky/provider/provider.dart';
import 'package:provider/provider.dart';

class InputText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    return TextField(
      cursorColor: colorsPalette['title'],
      style: GoogleFonts.nunito(
        color: colorsPalette['title'],
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
      decoration: InputDecoration(
        hintText: 'ICAO',
        filled: true,
        prefixIcon: Icon(Icons.search,
        color: colorsPalette['title']),
        fillColor: colorsPalette['input'],
        hintStyle: GoogleFonts.nunito(
          color: colorsPalette['title'],
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
      onSubmitted: (value) => provider.fetchWeather(value.trim())
    );
  }
}