// import 'dart:convert';
// import 'package:dav2/Models/resettlement_models/dataresettlement.dart';
// import 'package:dav2/screens/pdf.dart';
// import 'package:dav2/screens/pdf5.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// Future<Resettlement> fetchAlbum() async {
//   final response = await http.get(Uri.parse(
//       'https://iafpensioners.gov.in/ords/dav_portal/resettlement/resettlement'));
//
//   if (response.statusCode == 200) {
//     return Resettlement.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
//
// class Resettlement1 extends StatefulWidget {
//   const Resettlement1({Key? key}) : super(key: key);
//
//   @override
//   State<Resettlement1> createState() => _Resettlement1State();
// }
//
// class _Resettlement1State extends State<Resettlement1> {
//   String? localPath;
//   Future<Resettlement>? futureAlbum;
//
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     futureAlbum = fetchAlbum();
//
//     // ApiServiceProvider2.loadPDF().then((value) {
//     //   setState(() {
//     //     localPath = value;
//     //   });
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final maxLines;
//
//     return Scaffold(
//         backgroundColor: Color(0xFFf2fcff),
//
//         appBar: AppBar(
//           backgroundColor: Color(0xFFd3eaf2),
//           title: Row(
//
//             children: [
//
//               Image(image: AssetImage("assets/images/dav-new-logo.png",
//
//               ),
//                 fit: BoxFit.contain,
//                 height: 60,),
//               Container(
//                   padding: const EdgeInsets.all(8.0), child: Text('VAYU-SAMPARC'))
//             ],
//
//           ),
//
//         ),
//         body: SingleChildScrollView(
//             child: Center(
//                 child: FutureBuilder<Resettlement>(
//                   future: futureAlbum,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return Column(
//
//                         children: [
//                           Container(
//                             alignment: Alignment.topLeft,
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: MediaQuery.of(context).size.width / 20,
//                                 vertical: MediaQuery.of(context).size.width / 20,
//                               ),
//                               // padding:  EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
//                               child: Text(
//                                 "Resettlement",
//                                 style: TextStyle(
//                                   color: Color(0xFF394361),
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: 5,
//                               right: 5,
//                             ),
//                             // padding: EdgeInsets.fromLTRB(
//                             //     MediaQuery.of(context).size.width / 0.001, 0, 0.001, 0),
//                             child: Container(
//                                 color: Colors.white,
//                                 // color: Color(0xFFe7f2f9),
//                                 child: ListView.separated(
//                                     primary: false,
//                                     itemCount: snapshot.data!.items.length,
//                                     separatorBuilder: (context, position) => SizedBox(
//                                       height: 0,
//                                     ),
//                                     shrinkWrap: true,
//                                     itemBuilder: (context, position) {
//                                       return Container(
//                                         child: Table(
//                                           columnWidths: const {
//                                             0: FixedColumnWidth(50),
//                                             1: FlexColumnWidth(),
//                                             2: FixedColumnWidth(50),
//                                           },
//                                           border: TableBorder.all(
//                                             color: Colors.grey,
//                                           ),
//                                           children: [
//                                             TableRow(
//                                               //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.all(
//                                                       MediaQuery.of(context)
//                                                           .size
//                                                           .width /
//                                                           40),
//                                                   // padding: const EdgeInsets.all(8.0),
//                                                   child: Text(snapshot
//                                                       .data!.items[position].hsd_sr_no
//                                                       .toString()),
//                                                 ),
//
//                                                 Padding(
//                                                   padding: EdgeInsets.all(
//                                                       MediaQuery.of(context)
//                                                           .size
//                                                           .width /
//                                                           70),
//                                                   // padding: const EdgeInsets.all(8.0),
//                                                   child: Text(snapshot
//                                                       .data!.items[position].hsd_detail
//                                                       .toString()),
//                                                 ),
//
//
//
//                                                 Padding(
//                                                   padding: EdgeInsets.all(
//                                                       MediaQuery.of(context)
//                                                           .size
//                                                           .width /
//                                                           50),
//
//                                                   child: GestureDetector(
//                                                     onTap: () {
//                                                       Navigator.push(
//                                                           context,
//                                                           MaterialPageRoute(
//                                                               builder: (context) => pdf(snapshot.data!.items[position].hsd_pdf_link.toString())
//
//                                                           ));
//                                                     },
//                                                     child: Icon(
//                                                       Icons.picture_as_pdf,color: Colors.red,),
//
//                                                   ),
//
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     })),
//                           )
//                         ],
//                       );
//                     } else if (snapshot.hasError) {
//                       return Text('${snapshot.error}');
//                     }
//
//                     return CircularProgressIndicator();
//                   },
//                 ))));
//   }
// }
