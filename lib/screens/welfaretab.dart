import 'package:dav2/screens/diploma_certificate.dart';
import 'package:dav2/screens/issue_certificate.dart';
import 'package:flutter/material.dart';

class WelfareTab extends StatefulWidget {
  const WelfareTab({Key? key}) : super(key: key);
  @override
  State<WelfareTab> createState() => _WelfareTabState();
}

class _WelfareTabState extends State<WelfareTab> {
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
                padding: const EdgeInsets.all(8.0), child: Text('VAYU-SAMPARC'))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Diploma()),
                          // );
                        },
                        child: Card(
                          color: Color(0xFFd3eaf2),
                          child: Column(
                            children: [
                              Container(
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Diploma Certificates",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 30,),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Issue()),
                          // );
                        },
                        child: Card(
                          color: Color(0xFFd3eaf2),
                          child: Column(
                            children: [
                              Container(
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Issue Certificates",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 30,),
                    SizedBox(
                      width: size.width * 0.08,
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
