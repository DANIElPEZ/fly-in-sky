import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flyinsky/color/colors.dart';

class InputText extends StatelessWidget {
  InputText({required this.onSubmit});
  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
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
      onSubmitted: onSubmit
    );
  }
}