// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:dav2/screens/change_mpin.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'constant.dart';
// class Forgotpassword extends StatefulWidget {
//   const Forgotpassword({Key? key}) : super(key: key);
//
//   @override
//   State<Forgotpassword> createState() => _ForgotpasswordState();
// }
//
// class _ForgotpasswordState extends State<Forgotpassword> {
//
//   final TextEditingController _date = TextEditingController();
//   TextEditingController serviceNumberController = TextEditingController();
//   TextEditingController cat = TextEditingController();
//
//   List<String> items = <String>['Officer', 'Airmen/NCs(E)'];
//   String dropdownvalue = 'Officer';
//
//
//   var serviceNumber = "";
//   var category = "";
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     category = prefs.getString('Category') ?? "";
//     serviceNumber = prefs.getString('ServiceNumber') ?? "";
//
//
//     if (serviceNumber != "") {
//       serviceNumberController.text = serviceNumber;
//     }
//
//     setState(() {});
//   }
//
//   Future<void> doForgot() async {
//
//     setState(() {});
//
//     if (category != "") {
//       dropdownvalue = category;
//     }
//
//     var cat = "O";
//     if (dropdownvalue == "Officer" ) {
//       cat = "O";
//     } else {
//       cat = "A";
//     }
//
//     print("$baseURL/FORGETPINNEW//FORGETPINNEW/${serviceNumberController.text}/${_date.text.toString()}/$cat");
//
//     final response = await http.get(Uri.parse(
//         "$baseURL/FORGETPINNEW//FORGETPINNEW/${serviceNumberController.text}/${_date.text.toString()}/$cat"));
//     print(response.body);
//     var responseBody = jsonDecode(response.body);
//     if (responseBody["items"][0]["result"] == "NO") {
//       _showMyDialog("Invalid Credentials");
//     }else {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => ChangeMpin()),
//       );
//     }
//
//     setState(() {});
//   }
//   Future<void> _showMyDialog(message) async {
//     showDialog<String>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Error'),
//         content: Text(message),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'OK'),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFd3eaf2),
//         title: Row(
//           children: [
//             Image(image: AssetImage("assets/images/dav-new-logo.png",
//             ),
//               fit: BoxFit.contain,
//               height: 60,),
//             Container(
//                 padding: const EdgeInsets.all(8.0), child: Text('VAYU-SAMPARC'))
//           ],
//         ),
//       ),
//       body: ListView(children: [
//         SizedBox(height: 20,),
//         Container(
//           alignment: Alignment.center,
//           child: Text("Forgot Password",style: TextStyle(fontWeight: FontWeight.bold,
//             fontSize: 18,
//             color: Color(0xFF0b0c5b),
//           ),),),
//         if (category != "")
//           Padding(
//             padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
//             child: Visibility(
//               child:
//               Text((category == "A") ? "Airmen/NCs(E)" : "Officer"),
//               maintainSize: true,
//               maintainAnimation: true,
//               maintainState: true,
//               visible: false,
//             ),
//           ),
//         if (category == "")
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width / 40,
//               vertical: MediaQuery.of(context).size.width / 70,
//             ),
//             child: TextFormField(
//               validator: (value) {
//                 if (dropdownvalue == "") {
//                   return 'Please Select Category';
//                 } else {
//                   return null;
//                 }
//               },
//               decoration: InputDecoration(
//                 border: const OutlineInputBorder(),
//                 hintText: "Select",
//                 filled: true,
//                 fillColor: Colors.white,
//                 suffixIcon: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         dropdownvalue = newValue!;
//                       });
//                     },
//                     value: dropdownvalue,
//                     dropdownColor: const Color(0xFFf2fcff),
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     ),
//                     isExpanded: true,
//                     borderRadius: BorderRadius.circular(30),
//                     items: items.map<DropdownMenuItem<String>>(
//                           (String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Text(value),
//                           ),
//                         );
//                       },
//                     ).toList(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         if (serviceNumber != "")
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width / 40,
//                   vertical: MediaQuery.of(context).size.width / 70,
//                 ),
//                 child: Visibility(child: Text(serviceNumber),
//                   maintainSize: true,
//                   maintainAnimation: true,
//                   maintainState: true,
//                   visible: false,
//                 ),
//               ),
//             ],
//           ),
//         if (serviceNumber == "")
//           Padding(
//             padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
//             child: TextFormField(
//               controller: serviceNumberController,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter Service Number';
//                 } else {
//                   return null;
//                 }
//               },
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Service No",
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//           ),
//
//         Container(
//           alignment: Alignment.topLeft,
//           child: const Padding(
//             padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
//             child: Text(
//               "DOB",
//               style: TextStyle(
//                 // color: Color(0xFF0b0c5b),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//         ),
//      Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal:
//           MediaQuery.of(context).size.width /
//               40,
//           vertical:
//           MediaQuery.of(context).size.width /
//               120,
//         ),
//           child: TextFormField(
//             controller: _date,
//             validator: (value) {
//               if (_date.text == "") {
//                 return "Enter DOB";
//               } else {
//                 return null;
//               }
//             },
//             // onFieldSubmitted: _date.text,
//             autovalidateMode:
//             AutovalidateMode.onUserInteraction,
//             decoration: InputDecoration(
//               border: const OutlineInputBorder(),
//               hintText: "dd-MM-yyyy",
//               filled: true,
//               fillColor: Colors.white,
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.calendar_month_outlined),
//                 onPressed: () async {
//                   DateTime? pickeddate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(1901),
//                     lastDate: DateTime.now(),
//                   );
//                   if (pickeddate != null) {
//                     setState(() {
//                       _date.text = DateFormat('dd-MM-yyyy').format(pickeddate);
//                     });
//                   }
//                 },
//               ),
//             ),
//           ),
//       ),
//
//         SizedBox(height: 30,),
//         Container(
//           height: size.height * 0.06,
//           // height: 50,
//           width: double.infinity,
//           margin: const EdgeInsets.all(10),
//           child: ElevatedButton(
//             onPressed: () async {
//                 doForgot();
//             },
//             style: ElevatedButton.styleFrom(
//               // primary: const Color(0xFF0b0c5b),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(28))),
//             child: Text(
//               "Confirm",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';
import 'hmscreen1.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({Key? key}) : super(key: key);

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {

  final TextEditingController _date = TextEditingController();
  TextEditingController serviceNumberController = TextEditingController();
  TextEditingController cat = TextEditingController();
  var newmpinController = TextEditingController();
  bool _secureText = true;

  List<String> items = <String>['Officer', 'Airmen/NCs(E)'];
  String dropdownvalue = 'Officer';
  var isShowMpin = false;


  var serviceNumber = "";
  var category = "";

  @override
  void initState() {
    super.initState();
    getData();
    checkInternetConnection();
  }
  bool isLoading = true;
  bool isInternetConnection = true;
  void checkInternetConnection()async{
    bool internetConnection = await InternetConnectionChecker().hasConnection;
    if(internetConnection == true)
    {
      doForgot();
    }
    else
    {
      setState(() {
        isInternetConnection = false;
      });
      _showMyDialog1("Please check your internet connectivity");
    }


  }
  Future<void> _showMyDialog1(message) async {
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

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    category = prefs.getString('Category') ?? "";
    serviceNumber = prefs.getString('ServiceNumber') ?? "";


    if (serviceNumber != "") {
      serviceNumberController.text = serviceNumber;
    }

    setState(() {});
  }

  Future<void> updateMPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cat = "O";
    if (dropdownvalue == "Officer") {
      cat = "O";
    } else {
      cat = "A";
    }
    print("${baseURL}/UPDATEMPIN/UPDATEMPIN?SERVICE_NO=${serviceNumberController.text}&CATEGORY=${cat}&MPIN=${newmpinController.text.toString()}");

    final response = await http.put(Uri.parse("${baseURL}/UPDATEMPIN/UPDATEMPIN?SERVICE_NO=${serviceNumberController.text}&CATEGORY=${cat}&MPIN=${newmpinController.text.toString()}"),
        body: {
          "SERVICE_NO" : serviceNumberController.text,
          "CATEGORY" : cat,
          "MPIN" : newmpinController.text.toString(),
        }
    );
    print(response.body);
    if(response.body.trim() == "OK") {
      prefs.setString('MPIN', newmpinController.text.toString());
      Fluttertoast.showToast(msg: "Mpin Changed Successfully");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

    }else{
      _showMyDialog(response.body);
    }
  }

  Future<void> doForgot() async {

    if(isShowMpin){
      updateMPin();
      return;
    }

    setState(() {});

    if (category != "") {
      dropdownvalue = category;
    }

    var cat = "O";
    if (dropdownvalue == "Officer") {
      cat = "O";
    } else {
      cat = "A";
    }
print("$baseURL/FORGETPINNEW//FORGETPINNEW/${serviceNumberController.text}/${_date.text.toString()}/$cat");
    final response = await http.get(Uri.parse("$baseURL/FORGETPINNEW//FORGETPINNEW/${serviceNumberController.text}/${_date.text.toString()}/$cat"));
    var responseBody = jsonDecode(response.body);
    if (responseBody["items"][0]["result"] == "NO") {
      _showMyDialog("Invalid Credentials");
    }else {
      isShowMpin = true;
    }

    setState(() {});
  }
  Future<void> _showMyDialog(message) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
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

  void showMpinText(){
    if(_secureText){
      _secureText = false;
    }else{
      _secureText = true;
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        // backgroundColor: Color(0xFF394361),
        // actions: [
        //
        //   Image(image: AssetImage("assets/images/dav-new-logo.png")),
        // ],
        // title: Text(
        //   "VAYU-SAMPARC",
        //   // style: TextStyle(fontSize: 15),
        // ),

      ),

      body: ListView(children: [
        SizedBox(height: 20,),
        Container(
          alignment: Alignment.center,
          child: Text("Forgot Password",style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF0b0c5b),
          ),),),
        if (category != "")
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
            child: Visibility(
              child:
              Text((category == "A") ? "Airmen/NCs(E)" : "Officer"),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: false,
            ),
          ),
        if (category == "")
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 40,
              vertical: MediaQuery.of(context).size.width / 70,
            ),
            child: TextFormField(
              validator: (value) {
                if (dropdownvalue == "") {
                  return 'Please Select Category';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Select",
                filled: true,
                fillColor: Colors.white,
                suffixIcon: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                    value: dropdownvalue,
                    dropdownColor: const Color(0xFFf2fcff),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(30),
                    items: items.map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(value),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ),
        if (serviceNumber != "")
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 40,
                  vertical: MediaQuery.of(context).size.width / 70,
                ),
                child: Visibility(child: Text(serviceNumber),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: false,
                ),
              ),
            ],
          ),
        if (serviceNumber == "")
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
            child: TextFormField(
              controller: serviceNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Service Number';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Service No",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

        Container(
          alignment: Alignment.topLeft,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
            child: Text(
              "DOB",
              style: TextStyle(
                color: Color(0xFF0b0c5b),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
            MediaQuery.of(context).size.width /
                40,
            vertical:
            MediaQuery.of(context).size.width /
                120,
          ),
          child: TextFormField(
            controller: _date,
            validator: (value) {
              if (_date.text == "") {
                return "Enter DOB";
              } else {
                return null;
              }
            },
            // onFieldSubmitted: _date.text,
            autovalidateMode:
            AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "dd-MM-yyyy",
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () async {
                  DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1901),
                    lastDate: DateTime.now(),
                  );
                  if (pickeddate != null) {
                    setState(() {
                      _date.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                    });
                  }
                },
              ),
            ),
          ),
        ),

        SizedBox(height: 30,),

        if(isShowMpin)
          Container(
            alignment: Alignment.topLeft,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
              child: Text(
                "New MPIN",
                style: TextStyle(
                  color: Color(0xFF0b0c5b),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        if(isShowMpin)

          Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
            MediaQuery.of(context).size.width /
                40,
            vertical:
            MediaQuery.of(context).size.width /
                120,
          ),
            child: Pinput(
              controller: newmpinController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter MPIN';
                }
                if (value.length < 4) {
                  return "Please enter 4 digit MPIN";
                }
                return null;
              },
              length: 4,
              obscureText: true,
              obscuringCharacter: '●',
              onChanged: (value) {
                setState(() {
                  _secureText = !_secureText;
                });
              },
              showCursor: true,
              // onCompleted: (pin) => print(pin),
            ),
        ),

          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal:
          //     MediaQuery.of(context).size.width /
          //         40,
          //     vertical:
          //     MediaQuery.of(context).size.width /
          //         120,
          //   ),
          //   child: TextFormField(
          //     keyboardType: TextInputType.number,
          //     controller: newmpinController,
          //     autovalidateMode: AutovalidateMode.onUserInteraction,
          //     obscureText: _secureText,
          //     decoration: InputDecoration(
          //       border: const OutlineInputBorder(),
          //       hintText: "MPIN",
          //       filled: true,
          //       fillColor: Colors.white,
          //       suffixIcon: IconButton(
          //         icon: Icon(_secureText
          //             ? Icons.visibility_off
          //             : Icons.visibility),
          //         onPressed: () {
          //           showMpinText();
          //         },
          //       ),
          //     ),
          //
          //   ),
          //   // child: Pinput(
          //   //   controller: newmpinController,
          //   //   length: 4,
          //   //   obscureText: true,
          //   //   obscuringCharacter: '●',
          //   //   onChanged: (value) {
          //   //     setState(() {
          //   //       _secureText = !_secureText;
          //   //     }
          //   //     );
          //   //   },
          //   //
          //   //   showCursor: true,
          //   // ),
          // ),

        SizedBox(height: 20),

        Container(
          height: size.height * 0.06,
          // height: 50,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () async {
              doForgot();
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF0b0c5b),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28))),
            child: Text(
              "Confirm",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),

            ),
          ),
        ),
      ]),
    );
  }
}
