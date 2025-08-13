import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flyinsky/color/colors.dart';
import 'package:flyinsky/components/appBar.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ViewChecklist extends StatefulWidget {
  ViewChecklist({required this.pdf_file});

  final String pdf_file;

  @override
  State<StatefulWidget> createState() => StateViewChecklist();
}

class StateViewChecklist extends State<ViewChecklist> {
  String? localPath;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    final byteData = await rootBundle.load(
      'assets/checklist/${widget.pdf_file}',
    );
    final temDir = await getTemporaryDirectory();
    final file = await File('${temDir.path}/${widget.pdf_file}');
    await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

    setState(() {
      localPath = file.path;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: colorsPalette['light blue'],
        child:
            loading
                ? Center(child: CircularProgressIndicator())
                : PDFView(filePath: localPath,
            swipeHorizontal: true,
                //nightMode: true
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back,
        color: colorsPalette['title'],),
        backgroundColor: colorsPalette['input'],
      )
    );
  }
}
