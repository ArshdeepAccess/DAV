import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dav2/screens/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/form16Model.dart';
import 'constant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file_manager/open_file_manager.dart';


class Form16 extends StatefulWidget {

  const Form16({Key? key}) : super(key: key);
  @override
  State<Form16> createState() => _Form16State();
}

class _Form16State extends State<Form16> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  List<Form16Model> data = [];

  // var type = ["2019-20", "2020-21"];
  // var selectedType = "2019-20";
  // List<String> year = [];
  //
  //
  // String dropdownvalue = "";
  //
  // List<String> year = <String>['2015-16', '2016-17','2017-18','2018-19','2019-20','2020-21','2021-22','2022-23','2023-24',
  // ];
//
//   // List<String> year = [];
//   String dropdownvalue = '2015-16';
  @override
  void initState() {
    super.initState();
    // Initialize the notification plugin
    initializeNotifications();
    checkInternetConnection();
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // void fillArray(){
  //   // DateTime now = new DateTime.now();
  //   // int intYear = now.year;
  //   //
  //   // for(int i = 2015; i <= (intYear+1); i++ ){
  //   //   year.add((i.toString()+"-"+(i+1).toString()));
  //   // }
  //   dropdownvalue = year[0];
  //   getData(year[0]);
  // }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var serviceNumber = prefs.getString('ServiceNumber') ?? "";
    var cat = prefs.getString('Category') ?? "";
    print("$baseURL/form16download/form16download/$serviceNumber/$cat");
    final response = await http.get(Uri.parse("$baseURL/form16download/form16download/$serviceNumber/$cat"));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      data = (responseBody["items"] as List).map((data) => Form16Model.fromJson(data)).toList();
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

  Future<void> saveFile(url) async {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    if (dir != null) {
      String saveName = url.split('/').last;
      String savePath = "${dir.path}/$saveName";

      Fluttertoast.showToast(
        msg: "Downloading Start",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      try {
        await Dio().download(url, savePath, onReceiveProgress: (received, total) {
          if (total != -1) {
            print("${(received / total * 100).toStringAsFixed(0)}%");
          }
        });

        // Show a notification after the file is downloaded
        showDownloadNotification(savePath);

        Fluttertoast.showToast(
          msg: "File is saved to download folder.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } on DioError catch (e) {
        Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  void showDownloadNotification(savePath) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'File Downloaded',
      'The file has been downloaded successfully.',
      platformChannelSpecifics,
    ).then((value) => {
      openFileManager()
    });

    //await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: Column(

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
                "Form 16",
                style: TextStyle(
                  color: Color(0xFF394361),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          //
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: MediaQuery.of(context).size.width / 40,
          //     vertical: MediaQuery.of(context).size.width / 120,
          //   ),
          //
          //   // const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
          //   child: TextFormField(
          //
          //     decoration: InputDecoration(
          //       border: const OutlineInputBorder(),
          //       hintText: "Select",
          //       filled: true,
          //       fillColor: Colors.white,
          //       suffixIcon: DropdownButtonHideUnderline(
          //         child: DropdownButton<String>(
          //           onChanged: (newValue) {
          //             setState(() {
          //               dropdownvalue = newValue!;
          //               getData(newValue);
          //             });
          //           },
          //
          //           value: dropdownvalue,
          //           dropdownColor: const Color(0xFFf2fcff),
          //           style: const TextStyle(
          //             color: Colors.black,
          //             fontSize: 18,
          //             fontWeight: FontWeight.normal,
          //           ),
          //
          //           isExpanded: true,
          //           borderRadius: BorderRadius.circular(30),
          //           items: year.map<DropdownMenuItem<String>>(
          //                 (String value) {
          //               return DropdownMenuItem<String>(
          //                 value: value,
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(10.0),
          //                   child: Text(value),
          //                 ),
          //               );
          //             },
          //
          //           ).toList(),
          //
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: Container(
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
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 30,
                          vertical: MediaQuery.of(context).size.width / 40,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Column(
                                //   children: [
                                //     Text("Sr No:",
                                //       style: TextStyle(
                                //         fontWeight: FontWeight.w500,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                // Column(
                                //   children: [
                                //     Text(data[position].sr_no.toString()),
                                //   ],
                                // ),
                                // SizedBox(
                                //   width: 20,
                                // ),
                                Column(
                                  children: [
                                    Text("Year:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Text(data[position].tpf_fin_year),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text("Name:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Text(data[position].name),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text("PDF:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => pdf(
                                                  data[position].category),
                                            ));
                                      },
                                      child: Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text("DOWNLOAD PDF:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        saveFile(data[position]
                                            .category);
                                      },
                                      child: Icon(
                                        Icons.download,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              height: 10,
                              thickness: 0.1,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    })),
          )
        ],
      ),
    );
  }
}

