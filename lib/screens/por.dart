import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/PorModel.dart';
import 'constant.dart';

class Por extends StatefulWidget {
  const Por({Key? key}) : super(key: key);

  @override
  State<Por> createState() => _PorState();
}

class _PorState extends State<Por> {
  List<PorModel> data = [];

  @override
  void initState() {
    super.initState();
    getData();
    checkInternetConnection();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var serviceNumber = prefs.getString('ServiceNumber') ?? "";
    var cat = prefs.getString('Category') ?? "";

    final response = await http
        .get(Uri.parse("${baseURL}/VIEWPOR//VIEWPOR/${serviceNumber}/${cat}"));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      data = (responseBody["items"] as List)
          .map((data) => PorModel.fromJson(data))
          .toList();
      setState(() {});
    } else {
      throw Exception('Failed to load album');
    }
  }
  bool isLoading = true;
  bool isInternetConnection = true;
  void checkInternetConnection()async{
    bool internetConnection = await InternetConnectionChecker().hasConnection;
    if(internetConnection == true)
    {
      getData();
    }
    else
    {
      setState(() {
        isInternetConnection = false;
      });
      _showMyDialog("Please check your internet connectivity");
    }


  }
  Future<void> _showMyDialog(message) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('No Connection'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  "Details of POR",
                  style: TextStyle(
                    color: Color(0xFF394361),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),
            Container(
                // color: Colors.white,
                // color: Color(0xFFe7f2f9),
                child: ListView.separated(
                    primary: false,
                    itemCount: data.length,
                    separatorBuilder: (context, position) => SizedBox(
                          height: 0,
                        ),
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      return  Padding(
                          padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 30,
                vertical: MediaQuery.of(context).size.width / 40,
              ),
                        child: Column(
                              children: [

                                Row(
                                    children: [
                                      Column(
                                        children: [
                                       Text("Sr No:",
                                       style: TextStyle(
                                         fontWeight: FontWeight.w500,
                                       ),
                                       ),
                                        ],
                                      ),
                                      SizedBox(width: 5,),

                                      Column(
                                        children: [
                                          Text(data[position].rownum.toString()),
                                        ],
                                      ),
                                         SizedBox(width: 20,),
                                      Column(
                                        children: [
                                          Text("POR No:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 5,),

                                      Column(
                                        children: [
                                          Text(data[position].porNo.toString()),
                                        ],
                                      ),
                                      SizedBox(width: 20,),
                                      Column(
                                        children: [
                                          Text("POR Year:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 5,),
                                      Column(
                                        children: [
                                          Text(data[position].porYear.toString()),
                                        ],
                                      ),
                                    ],
                                ),
                                  SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text("POR Date:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 5,),
                                    Column(
                                      children: [
                                        Text(data[position].pordate.toString()),
                                      ],
                                    ),
                                    SizedBox(width: 8,),
                                    Column(
                                      children: [
                                        Text("POR Service No:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 5,),
                                    Column(
                                      children: [
                                        Text(data[position].porServiceNo.toString()),
                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text("POR Type:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 5,),
                                    Column(
                                      children: [
                                        Text(data[position].porTypeDesc.toString()),
                                      ],
                                    ),

                                  ],
                                ),

                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text("POR Occurance No.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 5,),
                                    Column(
                                      children: [
                                        Text(data[position].porOccuranceNo.toString()),
                                        // Row(
                                        //   children: [
                                        //     Text(data[position].add1A.toString()),
                                        //     Text(data[position].add2A.toString()),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     Text(data[position].add3A.toString()),
                                        //     Text(data[position].stateA.toString()),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     Text(data[position].pincodeA.toString()),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 5,),
                                Divider(
                                  height: 10,
                                  thickness: 0.4,
                                  color: Colors.grey,
                                ),
                              ],
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
