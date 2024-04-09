import 'package:dav2/Models/service_models/dataservice.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Form16pdf extends StatefulWidget {
  var url = "";
  Form16pdf(this.url);

  @override
  State<Form16pdf> createState() => Form16pdfState();
}

class Form16pdfState extends State<Form16pdf> {
  String? localPath;
  Future<Service>? futureAlbum;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF394361),
          title: Text(
            "SERVING THOSE WHO SERVED US",
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: SfPdfViewer.network(widget.url));
  }
}
