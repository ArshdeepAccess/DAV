// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:webview_flutter_plus/webview_flutter_plus.dart';
//
// class Welfare extends StatefulWidget {
//   const Welfare({Key? key}) : super(key: key);
//   @override
//   State<Welfare> createState() => _WelfareState();
// }
//
// class _WelfareState extends State<Welfare> {
//   late WebViewController controller;
//   var serviceNumber = "";
//   var cat = "";
//   var categoryController = TextEditingController();
//   var serviceNumberController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     serviceNumber = prefs.getString('ServiceNumber') ?? "";
//     cat = prefs.getString('Category') ?? "";
//     print(serviceNumber);
//     print(cat);
//     setState(() {});
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFd3eaf2),
//         title: Row(
//           children: [
//             Image(
//               image: AssetImage(
//                 "assets/images/dav-new-logo.png",
//               ),
//               fit: BoxFit.contain,
//               height: 60,
//             ),
//             Container(
//                 padding: const EdgeInsets.all(8.0), child: Text('VAYU-SAMPARC'))
//           ],
//         ),
//       ),
//       body: WebViewPlus(
//         javascriptMode: JavascriptMode.unrestricted,
//         initialUrl:
//         "https://iafpensioners.gov.in/ords/r/dav_portal/dte_av/certificate_request?P0_USER_SERVICE_NO=$serviceNumber&P0_USER_CATEGORY=$cat",
//         onWebViewCreated: (controller) {
//           this.controller = controller as WebViewController;
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class Welfare extends StatefulWidget {
  const Welfare({Key? key}) : super(key: key);

  @override
  State<Welfare> createState() => _WelfareState();
}

class _WelfareState extends State<Welfare> {
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
        "https://iafpensioners.gov.in/ords/r/dav_portal/dte_av/single-sign-on?P172_PK=$pk&CLEAR=6",
        onWebViewCreated: (controller) {
          this.controller = controller as WebViewController;
        },
      ),
    );
  }
}
