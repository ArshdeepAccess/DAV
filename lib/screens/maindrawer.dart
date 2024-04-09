import 'package:dav2/screens/Coursemateshome.dart';
import 'package:dav2/screens/Servicehome.dart';
import 'package:dav2/screens/Updateshome.dart';
import 'package:dav2/screens/change_mpin.dart';
import 'package:dav2/screens/disabilityhome.dart';
import 'package:dav2/screens/echshome.dart';
import 'package:dav2/screens/echsmap.dart';
import 'package:dav2/screens/familyhome.dart';
import 'package:dav2/screens/form16.dart';
import 'package:dav2/screens/noticeboard.dart';
import 'package:dav2/screens/por.dart';
import 'package:dav2/screens/profile.dart';
import 'package:dav2/screens/sparsh.dart';
import 'package:dav2/screens/splashscreen.dart';
import 'package:dav2/screens/welfaretab.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Contacts.dart';
import 'Iafba.dart';
import 'Ig6.dart';
import 'Resettlement.dart';
import 'eppo.dart';
import 'faqhome.dart';
import 'informationvideo.dart';

class Maindrawer extends StatefulWidget {
  const Maindrawer({Key? key}) : super(key: key);

  @override

  State<Maindrawer> createState() => _MaindrawerState();
}

class _MaindrawerState extends State<Maindrawer> {

  Future<void> doLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) {return const SplashScreen();}), (_) => false,);
  }

  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Color(0xFFf2fcff),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.width/10 ),
              child: ListTile(
                title: Text("Profile",
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xFF3c5393)),
                ),
              ),
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/User1.png"))),
              title: Text("Profile",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile()),
                );
              },
            ),
            ListTile(
              title: Text("Services",
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xFF3c5393)),
              ),
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                height: size.height * 0.03,
                width: size.width * 0.12,
                child: Image(
                    image: AssetImage(
                        "assets/images/eppo.png")),
              ),
              title: Text("EPPO",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Eppo()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/form16.png"))),
              title: Text("FORM 16",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Form16()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                height: size.height * 0.03,
                width: size.width * 0.12,
                child: Image(
                    image: AssetImage(
                        "assets/images/por.png")),
              ),
              title: Text("POR",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Por()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                height: size.height * 0.03,
                width: size.width * 0.12,
                child: Image(
                    image: AssetImage(
                        "assets/images/resettlement.png")),
              ),
              title: Text("IAFPC",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Resettlement1()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                height: size.height * 0.03,
                width: size.width * 0.12,
                child: Image(
                    image: AssetImage(
                        "assets/images/iafba-logo.png")),
              ),
              title: Text("IAFBA",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Iafba()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                height: size.height * 0.03,
                width: size.width * 0.12,
                child: Image(
                    image: AssetImage(
                        "assets/images/afgis_logo.png")),
              ),
              title: Text("AFGIS",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Ig6()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),


            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/echs.png"))),
              title: Text("ECHS/URC",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EchsMap()),
                );
              },
            ), Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/coursemates.png"))),
              title: Text("Course Mates",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Coursemates()),
                );
              },
            ), Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/welfare.png"))),
              title: Text("Welfare",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WelfareTab()),
                );
              },
            ), Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text("Information",
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xFF3c5393)),
              ),
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.02,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/update.png"))),
              title: Text("Updates",
                style: TextStyle(fontSize: 14),

              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Update1()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/noticeboard.png"))),
              title: Text("Notice Board",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoticeBoard()),
                );
              },
            ), Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/video.png"))),
              title: Text("Information Video",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InformationVideo()),
                );
              },
            ), Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/faq.png"))),
              title: Text("FAQs",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Faq1()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/servicep.png"))),
              title: Text("Service Pension",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Service1()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/disabilityp.png"))),
              title: Text("Disability Pension",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Disability1()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/familyp.png"))),
              title: Text("Family Pension",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Family1()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                height: size.height * 0.03,
                width: size.width * 0.12,
                child: Image(
                    image: AssetImage(
                        "assets/images/iaf-afg.png")),
              ),
              title: Text("SPARSH",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Sparsh()),
                );
              },
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/contacts.png"))),
              title: Text("Contacts",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Contacts()),
                );
              },
            ), Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,

                color: Colors.grey,
              ),
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/welfare.png"))),
              title: Text("Echs & Welfare Issues",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Echs1()),
                );
              },
            ), Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,

                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text("Settings",
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xFF3c5393)),
              ),
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/changempin.png"))
              ),
              title: Text("Change MPIN",
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeMpin()),
                );
              },
            ), Padding(
              padding:  EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:   Divider(
                height: 10,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.12,
                  child: Image(
                      image: AssetImage(
                          "assets/images/logout.png"))
              ),
              title: GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return Container(
                      child: AlertDialog(
                        title: Text("Are you sure you want to Logout"),
                        actions: [
                          TextButton(onPressed: (){
                            doLogout();
                          }, child: Text("Yes")),
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => HomeScreen()),
                            // );
                          }, child: Text("No")),

                        ],
                      ),
                    );
                  });
                },
                child: Text("LogOut",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              // onTap: () {
              //   doLogout();
              // },
            ),

          ],
        ),
      ),
    );
  }
}
