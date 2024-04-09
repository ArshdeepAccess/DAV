import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Resettlement1 extends StatefulWidget {
  const Resettlement1({Key? key}) : super(key: key);

  @override
  State<Resettlement1> createState() => _Resettlement1State();
}

class _Resettlement1State extends State<Resettlement1> {
  late WebViewController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   checkInternetConnection();
  // }
  // bool isLoading = true;
  // bool isInternetConnection = true;
  // void checkInternetConnection()async{
  //   bool internetConnection = await InternetConnectionChecker().hasConnection;
  //   if(internetConnection == true)
  //   {
  //     WebView(
  //       javascriptMode: JavascriptMode.unrestricted,
  //       initialUrl:
  //       "https://www.iafpc.co.in/",
  //       onWebViewCreated: (controller) {
  //         this.controller = controller;
  //       },
  //     );
  //   }
  //   else
  //   {
  //     setState(() {
  //       isInternetConnection = false;
  //     });
  //     _showMyDialog("Please check your internet connectivity");
  //   }
  //
  //
  // }
  // Future<void> _showMyDialog(message) async {
  //   showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text('No Connection'),
  //       content: Text(message),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, 'OK'),
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
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
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            "https://www.iafpc.co.in/",
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
      ),
    );
  }
}
