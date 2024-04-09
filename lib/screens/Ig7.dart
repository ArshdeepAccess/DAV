import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Ig7 extends StatefulWidget {
  const Ig7({Key? key}) : super(key: key);

  @override
  State<Ig7> createState() => _Ig7State();
}

class _Ig7State extends State<Ig7> {
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
        initialUrl: "https://iafpensioners.gov.in/ords/dav_portal/r/dte_av/useful-links?p0_title=OTHER%20LINKS",
        onWebViewCreated: (controller){
          this.controller = controller;
        },
      ),

    );
  }
}
