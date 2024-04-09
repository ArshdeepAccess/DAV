import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);
  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
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
              height: 5,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(8.0),
              child: Text(
                "Contact Us",
                style: TextStyle(
                  color: Color(0xFF394361),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("MONDAY TO FRIDAY 0900-1730h"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("SATURDAY 0900-1700h"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "POSTAL ADDRESS",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0b0c5b),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "OFFICERS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0b0c5b),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "AIRMEN",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0b0c5b),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("DTE OF AIR VETERANS"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("DTE OF AIR VETERANS"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("AIR HQ (SP)"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("AIR HQ (SP)"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("FIRST FLOOR, SMC BUILDING"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("THIRD FLOOR, AFRO BUILDING"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("SUBROTO PARK"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("SUBROTO PARK"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("NEW DELHI – 110 010"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("NEW DELHI – 110 010"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "EMAIL & Contact No's",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Color(0xFF0b0c5b),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 2,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Text(
                  //             "OFFICERS",
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Color(0xFF0b0c5b),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: size.width * 0.01,
                  //     ),
                  //     Expanded(
                  //       flex: 2,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           GestureDetector(
                  //               onTap: () async {
                  //                 Uri phoneno = Uri.parse('tel:7428926801');
                  //                 if (await launchUrl(phoneno)) {
                  //                   //dialer opened
                  //                 } else {
                  //                   //dailer is not opened
                  //                 }
                  //               },
                  //               child: Text(
                  //                 "7428926801",
                  //                 style: TextStyle(
                  //                   color: Colors.blue,
                  //                   fontSize: 12,
                  //                 ),
                  //               )),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: size.width * 0.01,
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Text(
                  //             "Fax",
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Color(0xFF0b0c5b),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: size.width * 0.01,
                  //     ),
                  //     Expanded(
                  //       flex: 2,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           GestureDetector(
                  //               onTap: () async {
                  //                 Uri phoneno = Uri.parse('tel:011-25683190');
                  //                 if (await launchUrl(phoneno)) {
                  //                   //dialer opened
                  //                 } else {
                  //                   //dailer is not opened
                  //                 }
                  //               },
                  //               child: Text(
                  //                 "011-25683190",
                  //                 style: TextStyle(
                  //                   color: Colors.blue,
                  //                   fontSize: 12,
                  //                 ),
                  //               )),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "OFFICERS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0b0c5b),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:7428926801');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "7428926801",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Fax"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:011-25683190');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "011-25683190",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("SERVICE PENSION"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Text("dav.officers@gov.in"),
                            GestureDetector(
                                onTap: () async {
                                  String email = Uri.encodeComponent(
                                      "dav.officers@gov.in");

                                  Uri mail = Uri.parse("mailto:$email?");
                                  if (await launchUrl(mail)) {
                                    //email app opened
                                  } else {
                                    //email app is not opened
                                  }
                                },
                                child: Text(
                                  "dav.officers@gov.in",
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("FAMILY PENSION"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Text(" dav.fp.officers@gov.in"),
                            GestureDetector(
                                onTap: () async {
                                  String email = Uri.encodeComponent(
                                      " dav.fp.officers@gov.in");

                                  Uri mail = Uri.parse("mailto:$email?");
                                  if (await launchUrl(mail)) {
                                    //email app opened
                                  } else {
                                    //email app is not opened
                                  }
                                },
                                child: Text(
                                  "dav.fp.officers@gov.in",
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("DISABLITY PENSION"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Text("dav.dp.officers@gov.in"),
                            GestureDetector(
                                onTap: () async {
                                  String email = Uri.encodeComponent(
                                      "dav.dp.officers@gov.in");

                                  Uri mail = Uri.parse("mailto:$email?");
                                  if (await launchUrl(mail)) {
                                    //email app opened
                                  } else {
                                    //email app is not opened
                                  }
                                },
                                child: Text(
                                  "dav.dp.officers@gov.in",
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "AIRMEN/NCs(E)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0b0c5b),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:7428926802');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "7428926802",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Fax"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:011-25696359');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "011-25696359",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("AIRMEN"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Text("dav.officers@gov.in"),
                            GestureDetector(
                                onTap: () async {
                                  String email =
                                      Uri.encodeComponent("dav.airmen@gov.in");

                                  Uri mail = Uri.parse("mailto:$email?");
                                  if (await launchUrl(mail)) {
                                    //email app opened
                                  } else {
                                    //email app is not opened
                                  }
                                },
                                child: Text(
                                  "dav.airmen@gov.in",
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("NCs(E)"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Text(" dav.fp.officers@gov.in"),
                            GestureDetector(
                                onTap: () async {
                                  String email =
                                      Uri.encodeComponent("dirav.nce@gov.in");

                                  Uri mail = Uri.parse("mailto:$email?");
                                  if (await launchUrl(mail)) {
                                    //email app opened
                                  } else {
                                    //email app is not opened
                                  }
                                },
                                child: Text(
                                  "dirav.nce@gov.in",
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Text(
                  //             "AIR CMDE AV SECTT",
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: size.width * 0.01,
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         GestureDetector(
                  //             onTap: () async {
                  //               Uri phoneno = Uri.parse('tel:011-25683190');
                  //               if (await launchUrl(phoneno)) {
                  //                 //dialer opened
                  //               } else {
                  //                 //dailer is not opened
                  //               }
                  //             },
                  //             child: Text(
                  //               "011-25683190,",
                  //               style: TextStyle(
                  //                 color: Colors.blue,
                  //                 // fontSize: 12,
                  //               ),
                  //             )),
                  //       ],
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         GestureDetector(
                  //             onTap: () async {
                  //               Uri phoneno = Uri.parse('tel:7428926803');
                  //               if (await launchUrl(phoneno)) {
                  //                 //dialer opened
                  //               } else {
                  //                 //dailer is not opened
                  //               }
                  //             },
                  //             child: Text(
                  //               "7428926803",
                  //               style: TextStyle(
                  //                 color: Colors.blue,
                  //                 // fontSize: 12,
                  //               ),
                  //             )),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Text(
                  //             "IAFPC",
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: size.width * 0.01,
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         GestureDetector(
                  //             onTap: () async {
                  //               Uri phoneno = Uri.parse('tel:011-25696013');
                  //               if (await launchUrl(phoneno)) {
                  //                 //dialer opened
                  //               } else {
                  //                 //dailer is not opened
                  //               }
                  //             },
                  //             child: Text(
                  //               "011-25696013,",
                  //               style: TextStyle(
                  //                 color: Colors.blue,
                  //                 // fontSize: 12,
                  //               ),
                  //             )),
                  //       ],
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         GestureDetector(
                  //             onTap: () async {
                  //               Uri phoneno = Uri.parse('tel:25690233');
                  //               if (await launchUrl(phoneno)) {
                  //                 //dialer opened
                  //               } else {
                  //                 //dailer is not opened
                  //               }
                  //             },
                  //             child: Text(
                  //               "25690233",
                  //               style: TextStyle(
                  //                 color: Colors.blue,
                  //                 // fontSize: 12,
                  //               ),
                  //             )),
                  //       ],
                  //     ),
                  //
                  //   ],
                  // ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "AIR CMDE AV SECTT",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:011-25683190');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "011-25683190,",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    // fontSize: 12,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:7428926803');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "7428926803",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    // fontSize: 12,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "IAFPC",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:011-25696013');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "011-25696013,",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    // fontSize: 12,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:25690233');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "25690233",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    // fontSize: 12,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Fax"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:011-25690233');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "011-25690233",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "VETERAN INFORMATION CELL",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0b0c5b),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Toll Free No."),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Text("011-25683170, 011-25683627"),
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:1800-11-5800');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "1800-11-5800",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "OFFICERS",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:011-25683170');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "011-25683170,",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    // fontSize: 12,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     GestureDetector(
                      //         onTap: () async {
                      //           Uri phoneno = Uri.parse('tel:011-25683627');
                      //           if (await launchUrl(phoneno)) {
                      //             //dialer opened
                      //           } else {
                      //             //dailer is not opened
                      //           }
                      //         },
                      //         child: Text(
                      //           "011-25683627",
                      //           style: TextStyle(
                      //             color: Colors.blue,
                      //             // fontSize: 12,
                      //           ),
                      //         )),
                      //   ],
                      // ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:011-25683627');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "011-25683627",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    // fontSize: 12,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "AIRMEN/NCs(E)",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:011-25687415');
                                  if (await launchUrl(phoneno)) {
                                  } else {}
                                },
                                child: Text(
                                  "011- 25687415,",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    // fontSize: 12,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "7194,95,96,97,",
                              style: TextStyle(
                                color: Colors.blue,
                                // fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "",
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:25696359');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Text(
                                  "25696359",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    // fontSize: 12,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Extn: 7355, 7336 ",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Portal Helpline"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:9041873400');
                                  if (await launchUrl(phoneno)) {
                                  } else {}
                                },
                                child: Text(
                                  "9041873400",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
