import 'package:flutter/material.dart';
import 'package:flyinsky/color/colors.dart';
import 'package:flyinsky/components/appBar.dart';
import 'package:flyinsky/components/card_aircraft_checklist.dart';
import 'package:flyinsky/components/custom_input_text.dart';
import 'package:flyinsky/blocs/checklist/checklist_bloc.dart';
import 'package:flyinsky/blocs/checklist/checklist_state.dart';
import 'package:flyinsky/blocs/checklist/checklist_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheclistView extends StatefulWidget {
  @override
  State<CheclistView> createState() => _CheclistViewState();
}

class _CheclistViewState extends State<CheclistView> {

  @override
  void initState() {
    super.initState();
    context.read<ChecklistBloc>().add(loadChecklists());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          input: InputText(
            hintText: 'AIRCRAFT',
            onSubmit: (value) {
              context.read<ChecklistBloc>().add(
                filteredChecklist(query: value),
              );
            },
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: colorsPalette['light blue'],
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: BlocBuilder<ChecklistBloc, ChecklistState>(
            builder: (context, state) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: state.checklists.length,
                itemBuilder: (context, index) {
                  return CardAircraft(
                    pdf_file: state.checklists[index]['pdf file'],
                    title: state.checklists[index]['name aircraft'],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
