import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dav2/screens/forgotpassword.dart';
import 'package:dav2/screens/vet_register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/login_model.dart';
import 'constant.dart';
import 'hmscreen1.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // late SharedPreferences prefs;
  // late String _lastLogin;
  bool _secureText = true;
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var serviceNumberController = TextEditingController();

  List<String> items = <String>['Officer', 'Airmen/NCs(E)'];
  String dropDownValue = 'Officer';

  var serviceNumber = "";
  var category = "";
  var Name = "";

  List<LoginModel> data = [];

  var pkController = TextEditingController();
  var pk = "";

  @override
  void initState() {
    super.initState();
    getData();
    // _initSharedPreferences();
  }

  @override
  void dispose() {
    passwordController.dispose(); // Dispose of the controller properly
    super.dispose();
  }
  // Future<void> _initSharedPreferences() async {
  //   prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _lastLogin = prefs.getString('last_login') ?? 'Never';
  //   });
  // }
  // Future<void> saveLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   DateTime now = DateTime.now();
  //   // String formattedDateTime = DateFormat("MM/dd/yyyy HH:mm").format(now);
  //   String formattedDateTime = "${now.month}/${now.day}/${now.year} ${now
  //       .hour}:${now.minute}";
  //   await prefs.setString('lastLoginTime', formattedDateTime);
  // }
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    category = prefs.getString('Category') ?? "";
    serviceNumber = prefs.getString('ServiceNumber') ?? "";
    Name = prefs.getString('name') ?? "";
    // pk = prefs.getString('PK') ?? "";
    // print(pk);
    print(Name);
    if (serviceNumber != "") {
      serviceNumberController.text = serviceNumber;
    }

    setState(() {});
  }

  Future<void> doLogin() async {
    DateTime now = DateTime.now();

// save the date and time to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastVisit', now.toString());
    // DateTime now = DateTime.now();
    // String currentTime = "${now.month}/${now.day}/${now.year} ${now.hour}:${now.minute}";
    // setState(() {
    //   _lastLogin = currentTime;
    // });
    // await prefs.setString('last_login', currentTime);

    isLoading = true;
    setState(() {});

    if (category != "") {
      dropDownValue = category;
    }

    var cat = "O";
    if (dropDownValue == "Officer" || dropDownValue == "O") {
      cat = "O";
    } else {
      cat = "A";
    }
    print(
        "$baseURL/MPINVALIDATE/MPINVALIDATE/${serviceNumberController.text}/$cat/${passwordController.text.toString()}");
    final response = await http.get(Uri.parse(
        "$baseURL/MPINVALIDATE/MPINVALIDATE/${serviceNumberController.text}/$cat/${passwordController.text.toString()}"));
    var responseBody = jsonDecode(response.body);

    if (responseBody["items"][0]["result"] == 0) {
      _showMyDialog("Invalid Login Details");
      // _showMyDialog(" ");

    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Category', cat);
      prefs.setString('ServiceNumber', serviceNumberController.text);

      prefs.setString('PK', pkController.text);
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      data = (responseBody["items"] as List)
          .map((data) => LoginModel.fromJson(data))
          .toList();
      print(data[0].pk);
      prefs.setString("PK", data[0].pk);

      prefs.setString('MPIN', passwordController.text.toString());
      Fluttertoast.showToast(msg: "Login Successfully");

      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
          return const HomeScreen();
        }),
        (_) => false,
      );
    }
    isLoading = false;
    setState(() {
      pkController.text = data[0].pk;
    });
  }

  Future<void> _showMyDialog(String message) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              setState(() {
                isLoading = false;
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final maxLines;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF394361),
          title: const Text(
            "VAYU-SAMPARC",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: const Color(0xFFf2fcff),
          child: Form(
            key: formKey,
            child: ListView(children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Container(
                height: size.height * 0.25,
                // height: 200,
                child: Image.asset(
                  "assets/images/newlogo.png",
                ),
              ),
              SizedBox(
                // height: 10,
                height: size.height * 0.015,
              ),
              if (Name != "")
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              AutoSizeText(
                                "Welcome",
                                style: TextStyle(
                                  // color: Color(0xFF0b0c5b),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                minFontSize: 3,
                                maxFontSize: 18,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Column(
                              children: [
                                AutoSizeText(
                                  Name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 3,
                                  maxFontSize: 18,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              SizedBox(
                // height: 10,
                height: size.height * 0.015,
              ),
              if (pk != "")
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              AutoSizeText(
                                "Welcome",
                                style: TextStyle(
                                  // color: Color(0xFF0b0c5b),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                minFontSize: 3,
                                maxFontSize: 18,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Column(
                              children: [
                                AutoSizeText(
                                  pk,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 3,
                                  maxFontSize: 18,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                      if (dropDownValue == "") {
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
                              dropDownValue = newValue!;
                            });
                          },
                          value: dropDownValue,
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
              //
              // Container(
              //   alignment: Alignment.topLeft,
              //   child: const Padding(
              //     padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
              //     child: Text(
              //       "Service Number",
              //       style: TextStyle(
              //         color: Color(0xFF0b0c5b),
              //         fontWeight: FontWeight.bold,
              //         fontSize: 15,
              //       ),
              //     ),
              //   ),
              // ),
              if (serviceNumber != "")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 40,
                        vertical: MediaQuery.of(context).size.width / 70,
                      ),
                      child: Text(serviceNumber),
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
                      } else if (value.length > 7) {
                        return 'Service number should not exceed 7';
                      }else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Service No",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                child: AutoSizeText(
                  "Enter Your MPIN",
                  style: TextStyle(
                    // color: Color(0xFF0b0c5b),
                    // fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  minFontSize: 3,
                  maxFontSize: 15,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 40,
                  vertical: MediaQuery.of(context).size.width / 70,
                ),
                child: Pinput(
                  controller: passwordController,
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

                // child: TextFormField(
                //   keyboardType: TextInputType.number,
                //   controller: passwordController,
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   obscureText: _secureText,
                //   decoration: InputDecoration(
                //     border: const OutlineInputBorder(),
                //     hintText: "MPIN",
                //     filled: true,
                //     fillColor: Colors.white,
                //     suffixIcon: IconButton(
                //       icon: Icon(_secureText
                //           ? Icons.visibility_off
                //           : Icons.visibility),
                //       onPressed: () {
                //
                //         setState(() {
                //           _secureText = !_secureText;
                //         });
                //       },
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter password';
                //     }
                //     if (value.length < 4) {
                //       return "Please enter 4 numbers";
                //     }
                //     return null;
                //   },
                // ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Forgotpassword()),
                      );
                    },
                    child: const AutoSizeText(
                      "Forget MPIN?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF0b0c5b),
                      ),
                      minFontSize: 3,
                      maxFontSize: 18,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              if (!isLoading)
                Container(
                  height: size.height * 0.06,
                  // height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        doLogin();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF0b0c5b),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28))),
                    child: const AutoSizeText(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      minFontSize: 3,
                      maxFontSize: 18,
                      maxLines: 2,
                    ),
                  ),
                ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),

              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('Last Login: $_lastLogin',style: TextStyle(),),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: const AutoSizeText(
                      "Register Yourself",
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                        // color: Color(0xFF0b0c5b),
                      ),
                      minFontSize: 3,
                      maxFontSize: 18,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
