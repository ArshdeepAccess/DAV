import 'dart:async';
import 'package:dav2/screens/VeteransLogin.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  // final String title;
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  //
  // static const String KEYREGISTER= "Register";
  // int _counter = 0;
  @override
  // Future<void> main() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // }
  void initState() {
    super.initState();
    // whereToGo();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message){
    //   RemoteNotification? notification=message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if(notification != null && android != null){
    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //
    //           color: Colors.blue,
    //           playSound: true,
    //
    //         ),
    //       ),
    //     );
    //   }
    // });
    Timer(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => Login(),
        ),
      );
    });
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if(notification != null && android !=null){
    //     showDialog(context: context,
    //         builder: (_){
    //       return AlertDialog(
    //         title: Text("notification.title"),
    //         content: SingleChildScrollView(
    //           child: Column (
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text("notification.body"),
    //             ],
    //           ),
    //         ),
    //       );
    //         });
    //   }
    //
    // });
  }
  // void showNotification(){
  //   setState(() {
  //     _counter++;
  //   });
  //   flutterLocalNotificationsPlugin.show(
  //     0,
  //     "Testing $_counter",
  //     "how you doin?",
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         channel.id,
  //         channel.name,
  //         importance: Importance.high,
  //         color: Colors.blue,
  //         playSound: true,
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    final maxLines;
    return Scaffold(
      backgroundColor: Color(0xFF9bbfd9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              // height: 250,
              // width: 350,
              height: size.height * 0.2,
              width: size.width * 60,
              child: Text("VAYU-SAMPARC", style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),),
            ),
            Container(
              child: Image.asset("assets/images/newlogo.png",
              ),
            ),

            Container(
              height: size.height * 0.3,
              width: size.width * 50,
              child: Padding(
                padding: EdgeInsets.fromLTRB(MediaQuery
                    .of(context)
                    .size
                    .width / 20, 90, 10, 5),
                // padding: const EdgeInsets.fromLTRB(20,60,7,0),30,70,10,5
                child: AutoSizeText(
                  "System of Automated Management of Pension and records ",
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  minFontSize: 14,
                  maxFontSize: 20,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}