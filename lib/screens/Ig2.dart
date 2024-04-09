import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Ig2 extends StatefulWidget {
  const Ig2({Key? key}) : super(key: key);

  @override
  State<Ig2> createState() => _Ig2State();
}

class _Ig2State extends State<Ig2> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFd3eaf2),
        title: Row(
          children: [
            Image(
              image: AssetImage(
                "assets/images/dav-new-logo.png",
              ),
              fit: BoxFit.contain,
              height: 60,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text('VAYU-SAMPARC'))
          ],
        ),
      ),
      // drawer: Maindrawer(),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "https://www.india.gov.in/",
        onWebViewCreated: (controller){
          this.controller = controller;
        },
      ),

    );
  }
}


