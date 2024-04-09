import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Ig4 extends StatefulWidget {
  const Ig4({Key? key}) : super(key: key);

  @override
  State<Ig4> createState() => _Ig4State();
}

class _Ig4State extends State<Ig4> {
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
        initialUrl: "https://joinindianarmy.nic.in/default.aspx",
        onWebViewCreated: (controller){
          this.controller = controller;
        },
      ),

    );
  }
}