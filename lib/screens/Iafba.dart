import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class Iafba extends StatefulWidget {
  const Iafba({Key? key}) : super(key: key);

  @override
  State<Iafba> createState() => _IafbaState();
}

class _IafbaState extends State<Iafba> {
  late WebViewController controller;

  var pkController = TextEditingController();

  var pk = "";
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pk = prefs.getString('PK') ?? "";
    print(pk);
    setState(() {});
  }

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
                padding: const EdgeInsets.all(8.0), child: Text('VAYU-SAMPARC'))
          ],
        ),
      ),
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
        "https://iafpensioners.gov.in/ords/dav_portal/r/iafba1/single-sign-on?P6_PK=$pk&CLEAR=6",
        onWebViewCreated: (controller) {
          this.controller = controller as WebViewController;
        },
      ),
    );
  }
}
