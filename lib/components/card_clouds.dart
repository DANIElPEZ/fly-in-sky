import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherfly/color/colors.dart';

class CardClouds extends StatelessWidget {
  CardClouds({required this.clouds});

  List<dynamic> clouds;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorsPalette['card blue'],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Clouds',
            style: GoogleFonts.nunito(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: colorsPalette['title'],
            ),
          ),
          Expanded(child: Container()),
          Text(
            clouds.toString(),
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: colorsPalette['content'],
            ),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
