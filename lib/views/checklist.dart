import 'package:flutter/material.dart';
import 'package:flyinsky/color/colors.dart';
import 'package:flyinsky/components/appBar.dart';
import 'package:flyinsky/components/card_aircraft_checklist.dart';
import 'package:flyinsky/data/checklist_aircrafts.dart';

class CheclistView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: colorsPalette['light blue'],
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: List_aircrafts.length,
            itemBuilder: (context, index) {
              return CardAircraft(pdf_file: List_aircrafts[index]['pdf file'],title: List_aircrafts[index]['name aircraft']);
            }
          ),
        )
      )
    );
  }
}