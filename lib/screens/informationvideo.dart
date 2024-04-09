import 'package:dav2/screens/video1.dart';
import 'package:dav2/screens/video2.dart';
import 'package:dav2/screens/video3.dart';
import 'package:flutter/material.dart';
class InformationVideo extends StatefulWidget {
  const InformationVideo({Key? key}) : super(key: key);

  @override
  State<InformationVideo> createState() => _InformationVideoState();
}

class _InformationVideoState extends State<InformationVideo> {


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final maxLines;
    return Scaffold(
      backgroundColor: Color(0xFFf2fcff),

      appBar: AppBar(
        backgroundColor: Color(0xFFd3eaf2),
        title: Row(

          children: [

            Image(image: AssetImage("assets/images/dav-new-logo.png",

            ),
              fit: BoxFit.contain,
              height: 60,),
            Container(
                padding: const EdgeInsets.all(8.0), child: Text('VAYU-SAMPARC'))
          ],

        ),

      ),
      body: SingleChildScrollView(

         child: Column(
           children: [
             Container(
               alignment: Alignment.topLeft,
               child: Padding(
                 padding: EdgeInsets.symmetric(
                   horizontal: MediaQuery.of(context).size.width / 20,
                   vertical: MediaQuery.of(context).size.width / 20,
                 ),
                 // padding:  EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                 child: Text(
                   "Information Video",
                   style: TextStyle(
                     color: Color(0xFF394361),
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
             ),

             Table(
                columnWidths: const {
                  0: FixedColumnWidth(50),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(50),
                },
                border: TableBorder.all(
                  color: Colors.grey,
                ),
                children: [
                  TableRow(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width /
                                40),
                        // padding: const EdgeInsets.all(8.0),
                        child: Text("1"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width /
                                70),
                        // padding: const EdgeInsets.all(8.0),
                        child: Text("LECTURES ON PENSION AND OTHER RETIREMENT BENEFITS : AIRMEN/NCs(E)"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width /
                                50),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoApp()));
                          },
                          child: Icon(
                            Icons.video_camera_back_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width /
                                40),
                        // padding: const EdgeInsets.all(8.0),
                        child: Text("2"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width /
                                70),
                        // padding: const EdgeInsets.all(8.0),
                        child: Text("LECTURES ON VARIOUS SCHEMES BY IAFBA."),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width /
                                50),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoApp2()));

                          },
                          child: Icon(
                            Icons.video_camera_back_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width /
                                40),
                        // padding: const EdgeInsets.all(8.0),
                        child: Text("3"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width /
                                70),
                        // padding: const EdgeInsets.all(8.0),
                        child: Text("FINAL CLEARANCE BRIEF : OFFICERS."),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width /
                                50),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoApp3()));
                          },
                          child: Icon(
                            Icons.video_camera_back_rounded,
                            color: Colors.red,
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
