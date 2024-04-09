import 'package:dav2/screens/pcda.dart';
import 'package:dav2/screens/sparshwebview.dart';
import 'package:flutter/material.dart';
import 'Ig1.dart';
import 'Ig2.dart';
import 'Ig3.dart';
import 'Ig4.dart';
import 'Ig5.dart';
import 'Ig7.dart';
import 'Ig8.dart';
import 'Ig9.dart';

class OtherLinks extends StatefulWidget {
  const OtherLinks({Key? key}) : super(key: key);
  @override
  State<OtherLinks> createState() => _OtherLinksState();
}

class _OtherLinksState extends State<OtherLinks> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFf2fcff),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 400),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ig1()),
                          );
                        },
                        // onTap: () =>
                        //     launchUrl(Uri.parse('  http://www.ksb.gov.in/')),
                        child: Container(
                          // height: 30,
                          // width: 150,
                          height: size.height * 0.09,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Img1.1.png"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 300),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ig2()),
                          );
                        },
                        // onTap: () =>
                        //     launchUrl(Uri.parse('https://www.india.gov.in/')),
                        child: Container(
                          // height: 30,
                          // width: 150,
                          height: size.height * 0.09,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Img2.png"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ig3()),
                          );
                        },
                        // onTap: () => launchUrl(
                        //     Uri.parse('https://indianairforce.nic.in/')),
                        child: Container(
                          // height:30,
                          // width: 150,
                          height: size.height * 0.09,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Img3.png"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 300),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ig4()),
                          );
                        },
                        // onTap: () => launchUrl(Uri.parse(
                        //     'https://joinindianarmy.nic.in/default.aspx')),
                        child: Container(
                          // height: 30,
                          // width: 150,
                          height: size.height * 0.09,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Img4.jpg"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 300),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ig5()),
                          );
                        },

                        // onTap: () => launchUrl(
                        //     Uri.parse('https://www.joinindiannavy.gov.in/')),
                        child: Container(
                          // height: 30,
                          // width: 150,
                          height: size.height * 0.09,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Img5.png"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 300),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ig7()),
                          );
                        },
                        // onTap: () => launchUrl(Uri.parse(
                        //     'https://iafpensioners.gov.in/ords/dav_portal/r/dte_av/useful-links?p0_title=OTHER%20LINKS')),
                        child: Container(
                          // height: 30,
                          // width: 150,
                          height: size.height * 0.09,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Img7.png"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 300),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ig8()),
                          );
                        },
                        // onTap: () =>
                        //     launchUrl(Uri.parse('https://www.mygov.in/')),
                        child: Container(
                          // height: 30,
                          // width: 150,
                          height: size.height * 0.09,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Img8.jpg"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 300),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ig9()),
                          );
                        },
                        // onTap: () =>
                        //     launchUrl(Uri.parse('https://www.desw.gov.in/')),
                        child: Container(
                          // height: 30,
                          // width: 150,
                          height: size.height * 0.09,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Img9.png"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 300),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SparshWebview()),
                          );
                        },
                        // onTap: () =>
                        //     launchUrl(Uri.parse('https://www.mygov.in/')),
                        child: Container(
                          // height: 30,
                          // width: 150,
                          height: size.height * 0.09,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/sparsh-logo.png"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 300),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Pcda()),
                          );
                        },
                        // onTap: () =>
                        //     launchUrl(Uri.parse('https://www.desw.gov.in/')),
                        child: Container(
                          // height: 30,
                          // width: 150,
                          height: size.height * 0.09,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/pcda.png"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
