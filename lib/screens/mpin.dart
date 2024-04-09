import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dav2/screens/forgotpassword.dart';
import 'package:dav2/screens/profile.dart';
import 'package:dav2/screens/vet_register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/login_model.dart';
import 'constant.dart';

class Mpin extends StatefulWidget {
  @override
  State<Mpin> createState() => _MpinState();
}

class _MpinState extends State<Mpin> {
  bool _secureText = true;
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var serviceNumberController = TextEditingController();

  List<String> items = <String>['Officer', 'Airmen/NCs(E)'];
  String dropDownValue = 'Officer';

  var serviceNumber = "";
  var category = "";


  List<LoginModel> data = [];

  var pkController = TextEditingController();
  var pk = "";

  @override
  void initState() {
    super.initState();
    getData();
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

  Future<void> doLogin() async {

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
      _showMyDialog("Invalid Mpin");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Category', cat);
      prefs.setString('ServiceNumber', serviceNumberController.text);
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      data = (responseBody["items"] as List)
          .map((data) => LoginModel.fromJson(data))
          .toList();
      print(data[0].pk);
      prefs.setString("PK", data[0].pk);
      prefs.setString('MPIN', passwordController.text.toString());
      // Fluttertoast.showToast(msg: "Login Successfully");
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
          return const Profile();
        }),
            (_) => false,
      );
    }
    isLoading = false;
    setState(() {
      pkController.text = data[0].pk;
    });
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
                  "assets/images/my_small_icon.png",
                ),
              ),

              SizedBox(
                // height: 10,
                height: size.height * 0.015,
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
                //
                // child: Pinput(
                //   controller: passwordController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter MPIN';
                //     }
                //     if (value.length < 4) {
                //       return "Please enter 4 digit MPIN";
                //     }
                //     return null;
                //   },
                //   length: 4,
                //   obscureText: true,
                //   obscuringCharacter: '●',
                //   onChanged: (value) {
                //     setState(() {
                //       _secureText = !_secureText;
                //     });
                //   },
                //   showCursor: true,
                //   // onCompleted: (pin) => print(pin),
                // ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: _secureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "MPIN",
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {

                        setState(() {
                          _secureText = !_secureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 4) {
                      return "Please enter 4 numbers";
                    }
                    return null;
                  },
                ),
              ),

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
                      "Verify",
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


            ]),
          ),
        ));
  }
}
