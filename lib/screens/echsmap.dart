import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:http/http.dart' as http;
import '../Models/CityModel.dart';
import '../Models/LocationModel.dart';
import 'constant.dart';
import 'dart:math' show cos, sqrt, asin;

class EchsMap extends StatefulWidget {
  const EchsMap({Key? key}) : super(key: key);

  @override
  State<EchsMap> createState() => _EchsMapState();
}

class _EchsMapState extends State<EchsMap> {
  List<CountryModel> stateData = [];
  List<LocationModel> locationData = [];

  var type = ["URC", "ECHS"];
  var selectedValue = "";
  var selectedState = "";
  var selectedType = null;

  double currentLat = 0;
  double currentLon = 0;

  bool isLoading = true;
  bool isInternetConnection = true;
  bool isFetchDisabled = true;

  @override
  void initState() {
    super.initState();
    getState();
    checkInternetConnection();
  }

  Future<void> getCurrentLoc() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(currentLat = position.latitude);
    print(currentLon = position.longitude);
    currentLat = position.latitude;
    currentLon = position.longitude;
  }

  Future<void> getState() async {
    await getCurrentLoc();
    final response = await http.get(Uri.parse("$baseURL/CITYFORMAP/CITYFORMAP/"));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      stateData = (responseBody["items"] as List)
          .map((data) => CountryModel.fromJson(data))
          .toList();
      selectedState = stateData[0].city_code;
      getLatLon();
      setState(() {});
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> getLatLon() async {
    if (selectedState != "" && selectedType != null) {
      var type = selectedType == "ECHS" ? "E" : "U";
      final response = await http.get(
          Uri.parse("$baseURL/MAP_URC_ECHS/MAP_URC_ECHS/$type/$selectedState"));
      var responseBody = jsonDecode(response.body);
      locationData = (responseBody["items"] as List)
          .map((data) => LocationModel.fromJson(data))
          .toList();
      for (int i = 0; i < locationData.length; i++) {
        locationData[i].distance = calculateDistance(
            currentLat,
            currentLon,
            double.parse(locationData[i].latitude),
            double.parse(locationData[i].longitude));
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    print(12742 * asin(sqrt(a)));
    return 12742 * asin(sqrt(a));
  }

  void openMap(index) {
    MapsLauncher.launchCoordinates(
        double.parse(locationData[index].latitude),
        double.parse(locationData[index].longitude));
  }

  void checkInternetConnection() async {
    bool internetConnection = await InternetConnectionChecker().hasConnection;
    if (internetConnection == true) {
      getState();
    } else {
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
        // backgroundColor: const Color(0xFF394361),
        // title: const Text(
        //   "VAYU-SAMPARC"
        //   // "Serving those who served us", style: TextStyle(fontSize: 15),
        // ),
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
                  "ECHS/URC",
                  style: TextStyle(
                    color: Color(0xFF394361),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Select State',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: stateData
                              .map((item) => DropdownMenuItem<String>(
                            value: item.city_code,
                            child: SizedBox(
                              // width: 110,
                              child: Text(item.city_name,
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.clip),
                            ),
                          ))
                              .toList(),
                          value: selectedState,
                          onChanged: (value) {
                            setState(() {
                              selectedState = value as String;
                            });
                            getLatLon();
                          },
                          buttonHeight: 40,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          'Select Type',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: type
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                              style: const TextStyle(fontSize: 14)),
                        ))
                            .toList(),
                        value: selectedType,
                        onChanged: (value) {
                          setState(() {
                            selectedType = value as String;
                            getLatLon();
                          });
                        },
                        buttonHeight: 40,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            // Container(
            //   padding: const EdgeInsets.all(5),
            //   decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButton2(
            //       hint: Text('Select Type', style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor,),),
            //       items: type.map((item) =>
            //           DropdownMenuItem<String>(
            //             value: item,
            //             child: Text(item, style: const TextStyle(fontSize: 14)),
            //           )).toList(),
            //       value: selectedType,
            //       onChanged: (value) {
            //         setState(() {
            //           selectedType = value as String;
            //           getLatLon();
            //         });
            //       },
            //       buttonHeight: 40,
            //       itemHeight: 40,
            //     ),
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.all(20),
              // child: Table(
              //
              //   columnWidths: const {
              //     0: FlexColumnWidth(),
              //     1: FixedColumnWidth(50),
              //
              //   },
              //   border: TableBorder.all(
              //       color: Colors.black, style: BorderStyle.solid, width: 2),
              //   children: [
              //     for(int i = 0; i < locationData.length; i++)
              //       TableRow(
              // //         children: [
              //           Column(
              //             children: [
              //               Padding(
              //                 padding: EdgeInsets.all(20.0),
              //                 child: Text(locationData[i].locationDesc.toString()),
              //               ),
              //             ],
              //           ),
              //           InkWell(
              //             onTap: () => {
              //               openMap(i)
              //             },
              //             child: Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Icon(Icons.location_pin,color: Colors.red,),
              //             ),
              //           ),
              //
              //         ],
              //       ),
              //   ],
              // ),

              child: Column(
                children: [
                  for (int i = 0; i < locationData.length; i++)
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: 50,
                          height: size.height * 0.07,
                          // width: 200,
                          width: size.width * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locationData[i].locationDesc.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 0.4,
                          color: Colors.grey,
                        ),
                        // SizedBox(
                        //   width: 20,
                        // ),

                        Expanded(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () => {openMap(i)},
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                locationData[i].distance.toStringAsFixed(2) +
                                    " KM",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 0.4,
                          color: Colors.grey,
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
