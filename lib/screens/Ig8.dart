import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Ig8 extends StatefulWidget {
  const Ig8({Key? key}) : super(key: key);

  @override
  State<Ig8> createState() => _Ig8State();
}

class _Ig8State extends State<Ig8> {
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
        initialUrl: "https://www.mygov.in/",
        onWebViewCreated: (controller){
          this.controller = controller;
        },
      ),

    );
  }
}
