import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dav2/screens/sparsh.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/config/recognition_config.dart';
import 'package:google_speech/config/recognition_config_v1.dart';
import 'package:google_speech/config/streaming_recognition_config.dart';
import 'package:google_speech/speech_client_authenticator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dav2/screens/Contacts.dart';
import 'package:dav2/screens/Coursemateshome.dart';
import 'package:dav2/screens/disabilityhome.dart';
import 'package:dav2/screens/echshome.dart';
import 'package:dav2/screens/echsmap.dart';
import 'package:dav2/screens/eppo.dart';
import 'package:dav2/screens/familyhome.dart';
import 'package:dav2/screens/form16.dart';
import 'package:dav2/screens/informationvideo.dart';
import 'package:dav2/screens/maindrawer.dart';
import 'package:dav2/screens/noticeboard.dart';
import 'package:dav2/screens/otherlinks.dart';
import 'package:dav2/screens/por.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Models/pfofilenameModel.dart';
import 'Iafba.dart';
import 'Ig6.dart';
import 'Resettlement.dart';
import 'Servicehome.dart';
import 'Updateshome.dart';
import 'constant.dart';
import 'faqhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var cat = "";
  var pkController = TextEditingController();

  var pk = "";
  // Future<void> getdata() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   serviceNumber = prefs.getString('ServiceNumber') ?? "";
  //   cat = prefs.getString('Category') ?? "";
  //   print(serviceNumber);
  //   print(cat);
  //   setState(() {});
  // }

  Future<void> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pk = prefs.getString('PK') ?? "";
    print(pk);
    setState(() {});
  }
  void _launchURL() async {
    final url = 'https://iafpensioners.gov.in/ords/r/dav_portal/dte_av/single-sign-on?P172_PK=$pk&CLEAR=6';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<ProfilenameModel> data = [];
  late String _lastVisitTimeText = '';
  // late String _lastVisitTimeText;
  final DateFormat _dateFormat = DateFormat.yMd().add_jm();
  @override

  void initState() {
    super.initState();
    _recorder.initialize();
    Future.value().whenComplete(() => welcomePopUp(context));
    getData();
    getPermission();
    _lastVisitTimeText = '';
    _getLastVisitTime();
    getdata();
  }

  Future<void> _getLastVisitTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? lastVisitTimeString = prefs.getString('lastVisitTime');
    if (lastVisitTimeString != null) {
      final DateTime lastVisitTime = DateTime.parse(lastVisitTimeString);
      setState(() {
        _lastVisitTimeText = _dateFormat.format(lastVisitTime);
      });
    } else {
      setState(() {
        _lastVisitTimeText = 'This is your first visit!';
      });
    }
    prefs.setString('lastVisitTime', DateTime.now().toString());
  }

  // Future<String> getLastLoginTime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String lastLoginTime = prefs.getString('lastLoginTime') ?? 'N/A';
  //   return lastLoginTime;
  // }

  Future<void> getPermission() async {
    await [
      Permission.location,
      Permission.manageExternalStorage,
      Permission.storage,
      Permission.phone
    ].request();

    // Map<Permission, PermissionStatus> statuses = await [Permission.location].request();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var categoryController = TextEditingController();
  var serviceNumberController = TextEditingController();

  List<String> items = <String>['Officer', 'Airmen/NCs(E)'];
  String dropDownValue = 'Officer';

  var serviceNumber = "";
  var category = "";
  var name = "";

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var serviceNumber = prefs.getString('ServiceNumber') ?? "";
    var cat = prefs.getString('Category') ?? "";

    final response = await http.get(Uri.parse(
        "${baseURL}/PROFILEDETAIL/PROFILEDETAIL/${serviceNumber}/${cat}"));
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Name', nameController.text);
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      data = (responseBody["items"] as List)
          .map((data) => ProfilenameModel.fromJson(data))
          .toList();
      print(data[0].av_name);
      prefs.setString("name", data[0].av_name);
      setState(() {
        nameController.text = data[0].av_name;
        serviceNumberController.text = data[0].user_service_no;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  final RecorderStream _recorder = RecorderStream();

  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;


  void streamingRecognize() async {
    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      _audioStream!.add(event);
    });

    await _recorder.start();

    setState(() {
      recognizing = true;
    });

    final serviceAccount = ServiceAccount.fromString((await rootBundle.loadString('assets/snappy-sight-394810-45d6ec568de8.json')));
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = _getConfig();

    final responseStream = speechToText.streamingRecognize(StreamingRecognitionConfig(config: config, interimResults: true), _audioStream!);
    var responseText = '';

    responseStream.listen((data) {
      final currentText = data.results.map((e) => e.alternatives.first.transcript).join('\n');
      print(currentText);

      if (data.results.first.isFinal) {
        responseText += '\n' + currentText;
        setState(() {
          text = responseText;
          recognizeFinished = true;
        });
        stopRecording();
      } else {
        setState(() {
          text = responseText + '\n' + currentText;
          recognizeFinished = true;
        });
      }
    }, onDone: () {
      setState(() {
        recognizing = false;
      });
    });
  }

  void stopRecording() async {
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
    var speachword = text;
    text = text.replaceAll(" ", '');
    text = text.replaceAll(".", '');
    print("text = " + text);

    var found = false;

    if(text.toLowerCase().contains("eppo")){
     found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Eppo()));
    }

    if(text.toLowerCase().contains("form 16")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Form16()));
    }

    if(text.toLowerCase().contains("por")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Por()));
    }

    if(text.toLowerCase().contains("iafpc")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Resettlement1()));
    }

    if(text.toLowerCase().contains("iafba")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Iafba()));
    }

    if(text.toLowerCase().contains("afgis")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Ig6()));
    }

    if(text.toLowerCase().contains("echs") || text.toLowerCase().contains("urc")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => EchsMap()));
    }

    if(text.toLowerCase().contains("course mate") || text.toLowerCase().contains("class mate")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Coursemates()));
    }

    if(text.toLowerCase().contains("welfare")){
      found = true;
      _launchURL();
    }

    if(text.toLowerCase().contains("update")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Update1()));
    }

    if(text.toLowerCase().contains("noticeboard")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeBoard()));
    }

    if(text.toLowerCase().contains("informationvideo")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => InformationVideo()));
    }

    if(text.toLowerCase().contains("faq")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Faq1()));
    }

    if(text.toLowerCase().contains("servicepension")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Service1()));
    }

    if(text.toLowerCase().contains("disabilitypension")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Disability1()));
    }

    if(text.toLowerCase().contains("familypension")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Family1()));
    }

    if(text.toLowerCase().contains("sparsh")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Sparsh()));
    }

    if(text.toLowerCase().contains("contactus")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Contacts()));
    }

    if(text.toLowerCase().contains("echs")){
      found = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Echs1()));
    }

    if(found == false){
      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('No Match Found'),
              content: Text("No module found matching with " + speachword),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
            },
            );
    }
    setState(() {
      recognizing = false;
    });
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'en-US');


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF394361),
        title: Text("VAYU-SAMPARC", style: TextStyle(fontSize: 20)),
        actions: [
          IconButton(
          onPressed: recognizing ? stopRecording : streamingRecognize,
          icon: Icon(!recognizing ? Icons.mic : Icons.mic_none)
          ),

          Image(
              image: AssetImage(
            "assets/images/newlogo.png",
          )),
        ],
      ),
      drawer: Maindrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body: SizedBox(
                            height: size.height,
                            child: PhotoView(
                              imageProvider: AssetImage("assets/images/B2.jpg"),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage("assets/images/B2.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // Container(
                //   margin: EdgeInsets.all(6.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8.0),
                //     image: DecorationImage(
                //       image: AssetImage(
                //         "assets/images/B2.jpg",
                //       ),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body: SizedBox(
                            height: size.height,
                            child: PhotoView(
                              imageProvider:
                                  AssetImage("assets/images/hm-5.jpg"),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage("assets/images/hm-5.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body: SizedBox(
                            height: size.height,
                            child: PhotoView(
                              imageProvider:
                                  AssetImage("assets/images/hm-6.jpg"),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage("assets/images/hm-6.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 190.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.9,
              ),
            ),

            // Container(
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            //     child: Container(
            //       color: Colors.grey.withOpacity(0.1),
            //     ),
            //   ),
            //   height: size.height * 0.25,
            //   width: size.width * 1.5,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(
            //         "assets/images/B2.jpg",
            //       ),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
            Card(
              color: Color(0xFFf2fcff),
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width / 20,
                horizontal: MediaQuery.of(context).size.width / 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 30),
                        child: Text(
                          "Services",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF474b50),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 10,),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Eppo()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image:
                                          AssetImage("assets/images/eppo.png"),
                                      // AssetImage("assets/images/eppo-1.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "EPPO",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Form16()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          // "assets/images/form16-1.png"),
                                          "assets/images/form16.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "Form 16",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Por()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image:
                                          // AssetImage("assets/images/por-1.png"),
                                          AssetImage("assets/images/por.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "POR",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Resettlement1()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          // "assets/images/iafpc.png"),
                                          "assets/images/resettlement.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "IAFPC",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                    ],
                  ),
                  // SizedBox(height: 10,),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Iafba()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/iafba-logo.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "IAFBA",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Ig6()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/afgis_logo.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "AFGIS",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EchsMap()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image:
                                          // AssetImage("assets/images/echs-1.png"),
                                          AssetImage("assets/images/echs.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "ECHS/URC",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Coursemates()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          // "assets/images/coursemates1.png"),
                                          "assets/images/coursemates.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "Course Mates",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: _launchURL,

                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Welfare()),
                          //   );
                          // },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          // "assets/images/coursemates1.png"),
                                          "assets/images/welfare.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "Welfare",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: Column(
                          children: [],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: Column(
                          children: [],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: Column(
                          children: [],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),
            Card(
              color: Color(0xFFf2fcff),
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width / 150,
                horizontal: MediaQuery.of(context).size.width / 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 30),
                        child: Text(
                          "Information",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF474b50),
                          ),
                        ),
                      )
                    ],
                  ),
                  // SizedBox(height: 10,),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Update1()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          // "assets/images/update1.png"),
                                          "assets/images/update.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "Updates",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeBoard()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          // "assets/images/notice.png"),
                                          "assets/images/noticeboard.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "Notice Board",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => InformationVideo()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image:
                                          AssetImage("assets/images/video.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "Information Video",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Faq1()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image:
                                          AssetImage("assets/images/faq.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "FAQs",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Service1()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/servicep.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "Service Pension",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Disability1()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/disabilityp.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "Disability Pension",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Family1()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/familyp.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "Family Pension",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Sparsh()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/iaf-afg.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "SPARSH",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Contacts()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/contacts.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "Contact Us",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30,),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Echs1()));
                          },
                          child: Card(
                            color: Color(0xFFd3eaf2),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/welfare.png"),
                                      height: size.height * 0.02,
                                      width: size.width * 0.15),
                                ),
                                Container(
                                    height: 20,
                                    child: Text(
                                      "ECHS & Welfare",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: Column(
                          children: [],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: Column(
                          children: [],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     SizedBox(
                  //       width: size.width * 0.08,
                  //     ),
                  //     Expanded(
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(builder: (context) => Sparsh()),
                  //           );
                  //         },
                  //         child: Card(
                  //           color: Color(0xFFd3eaf2),
                  //           child: Column(
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.only(top: 8.0),
                  //                 child: Image(
                  //                     image:
                  //                     AssetImage("assets/images/iaf-afg.png"),
                  //                     height: size.height * 0.02,
                  //                     width: size.width * 0.15),
                  //               ),
                  //               Container(
                  //                   height: 20,
                  //                   child: Text(
                  //                     "SPARSH",
                  //                     textAlign: TextAlign.center,
                  //                     style: TextStyle(
                  //                         fontSize: 7,
                  //                         fontWeight: FontWeight.bold),
                  //                   )),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     // SizedBox(width: 30,),
                  //     SizedBox(
                  //       width: size.width * 0.08,
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         children: [],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: size.width * 0.08,
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         children: [],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: size.width * 0.08,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => OtherLinks()),
            //     );
            //   },
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: const AutoSizeText(
            //       "External Links....",
            //       style: TextStyle(
            //         fontSize: 15,
            //       ),
            //       minFontSize: 3,
            //       maxFontSize: 18,
            //       maxLines: 2,
            //     ),
            //   ),
            // ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last visit: $_lastVisitTimeText',
                ),
                // Text('Last Login: ${_getLastLoginTime()}'),

                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 2.0),
                //     child: Column(
                //       children: [
                //       FutureBuilder<String>(
                //         future: getLastLoginTime(),
                //         builder: (context, snapshot) {
                //           if (snapshot.connectionState == ConnectionState.waiting) {
                //             return CircularProgressIndicator();
                //           } else if (snapshot.hasError) {
                //             return Text('Last Visit: Never');
                //           } else {
                //             return Text('Last Visit: ${snapshot.data}');
                //           }
                //         },
                //       ),
                //
                //     ],),
                //   ),
                // ),
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: AlertDialog(
                                    title: Text(
                                        "You are going out of Vayu-Samparc. If you are okay with it, you can proceed."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OtherLinks()),
                                            );
                                          },
                                          child: Text("Okay")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel")),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: const AutoSizeText(
                            "External Links....",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            minFontSize: 3,
                            maxFontSize: 18,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     FutureBuilder<String>(
            //       future: getLastLoginTime(),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return CircularProgressIndicator();
            //         } else if (snapshot.hasError) {
            //           return Text('Error: ${snapshot.error}');
            //         } else {
            //           return Text('Last Login: ${snapshot.data}');
            //         }
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  void welcomePopUp(
    context,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Colors.black, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(18)),
            content: Builder(builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Jai Hind",
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                        readOnly: true,
                        controller: nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF0b0c5b),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28))),
                        child: Text(
                          "OK",
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}
