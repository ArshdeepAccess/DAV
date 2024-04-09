import 'dart:convert';
import 'package:dav2/screens/help.dart';
import 'package:dav2/screens/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_number/mobile_number.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'VeteransLogin.dart';
import 'constant.dart';
import 'hmscreen1.dart';
import 'mobile number.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static String verify = "";
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _secureText = true;
  bool isLoading = false;

  TextEditingController cat = TextEditingController();

//   bool validateMobile(String mobile) {
//     final RegExp mobileRegex = RegExp(r'^[6-9]\d{9}$');
//     return mobileRegex.hasMatch(mobile);
//   }
//
  TextEditingController serviceNumber = TextEditingController();
  TextEditingController aadharNumber = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _date1 = TextEditingController();
  final TextEditingController _date2 = TextEditingController();
  TextEditingController panNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  List<String> items = <String>['Officer', 'Airmen/NCs(E)'];
  String dropdownvalue = 'Officer';

  var phone = "";

  @override
  void initState() {
    super.initState();
    getPermission();
    mobileController.text = "+91";
  }

  Future<void> getPermission() async {
    await MobileNumber.requestPhonePermission;
    final String? mobileNumber = await MobileNumber.mobileNumber;
    mobileController.text = mobileNumber ?? "";
  }

  Future<void> doRegister() async {
    isLoading = true;
    setState(() {});

    var cat = "O";
    if (dropdownvalue == "Officer") {
      cat = "O";
    } else {
      cat = "A";
    }
    print(
        "${baseURL}/registeration//registeration/${serviceNumber.text}/${cat}/${_date.text}/${_date1.text}/${_date2.text}/${password.text}/${panNumber.text}/${mobileController.text}/${aadharNumber.text}/${email.text}");
    final response = await http.get(Uri.parse(
        "${baseURL}/registeration//registeration/${serviceNumber.text}/${cat}/${_date.text}/${_date1.text}/${_date2.text}/${password.text}/${panNumber.text}/${mobileController.text}/${aadharNumber.text}/${email.text}"));
    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (responseBody["items"][0]["result"] == "OK") {
        insetData();
        Fluttertoast.showToast(msg: "Registered Successfully");
      } else {
        _showMyDialog(responseBody["items"][0]["msg"]);
        isLoading = false;
        setState(() {});
      }
    } else {
      _showMyDialog("connectivity issue from server");
      isLoading = false;
      setState(() {});
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

  Future<void> insetData() async {
    var cat = "O";
    if (dropdownvalue == "Officer") {
      cat = "O";
    } else {
      cat = "A";
    }

    final response = await http
        .post(Uri.parse("${baseURL}/insertdetails/insertdetails"), body: {
      "AADHAR": aadharNumber.text,
      "MOBILE": mobileController.text,
      "SERVICE_NO": serviceNumber.text,
      "CATEG": cat,
      "PEN_DOB": _date.text,
      "PEN_DOC": _date1.text,
      "PEN_MPIN": password.text,
      "PANNO": panNumber.text,
      "EMAIL": email.text,
      "PEN_DOD": _date2.text
    });

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Category', cat);
      prefs.setString('ServiceNumber', serviceNumber.text);
      prefs.setString('MPIN', password.text);
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
          return const HomeScreen();
        }),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF394361),
        leading: InkWell(
          onTap: () => {Navigator.of(context).pop()},
          child: const Icon(Icons.keyboard_arrow_left,
              size: 30, color: Colors.white),
        ),
        title: const Text(
          "Register Yourself",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Container(
        color: const Color(0xFFf2fcff),
        child: Form(
          key: _FormKey,
          child: ListView(children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 20.0, 150.0, 0.0),
                child: Text(
                  "Category",
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
                horizontal: MediaQuery.of(context).size.width / 40,
                vertical: MediaQuery.of(context).size.width / 120,
              ),

              // const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
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
            Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
                child: Text(
                  "Service Number",
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
                horizontal: MediaQuery.of(context).size.width / 40,
                vertical: MediaQuery.of(context).size.width / 120,
              ),
              child: TextFormField(
                controller: serviceNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Service Number';
                  } else if (value.length > 7) {
                    return 'Service number should not exceed 7';
                  } else {
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
            Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
                child: Text(
                  "Aadhar No.",
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
                horizontal: MediaQuery.of(context).size.width / 40,
                vertical: MediaQuery.of(context).size.width / 120,
              ),
              child: TextFormField(
                  controller: aadharNumber,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "AADHAR NO",
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'(^(?:[+0]9)?[0-9]{12}$)').hasMatch(value)) {
                      return "Enter Aadhar number";
                    } else {
                      return null;
                    }
                  }),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
                child: Text(
                  "Mobile No.",
                  style: TextStyle(
                    color: Color(0xFF0b0c5b),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: MediaQuery.of(context).size.width / 40,
                      //     vertical: MediaQuery.of(context).size.width / 120,
                      //   ),
                      //   child: TextFormField(
                      //       // controller: mobileController,
                      //       keyboardType: TextInputType.phone,
                      //           onChanged: (value) {
                      //             phone = value;
                      //           },
                      //       autovalidateMode: AutovalidateMode.onUserInteraction,
                      //       decoration: const InputDecoration(
                      //         border: OutlineInputBorder(),
                      //         hintText: "Mobile Number",
                      //         filled: true,
                      //         fillColor: Colors.white,
                      //       ),
                      //       validator: (value) {
                      //         if (value!.isEmpty ||
                      //             !RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                      //           return "Enter Mobile number";
                      //         } else {
                      //           return null;
                      //         }
                      //       }),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 40,
                          vertical: MediaQuery.of(context).size.width / 120,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phone = value;
                          },

                          // controller: mobileController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Mobile Number"),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: MediaQuery.of(context).size.width / 40,
                      //     vertical: MediaQuery.of(context).size.width / 120,
                      //   ),
                      //   child: TextFormField(
                      //     keyboardType: TextInputType.phone,
                      //     onChanged: (value) {
                      //       phone = value;
                      //     },
                      //     validator: (value) {
                      //       if (value!.isEmpty ||
                      //           !RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                      //         return "Enter Mobile number";
                      //       } else {
                      //         return null;
                      //       }
                      //     },
                      //     decoration: InputDecoration(
                      //       border: OutlineInputBorder(),
                      //       filled: true,
                      //       fillColor: Colors.white,
                      //       hintText: "Mobile Number",
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '${mobileController.text + phone}',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                Mobile.verify = verificationId;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Otp()),
                                );
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF0b0c5b),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
                          child: Text("OTP"))
                    ],
                  ),
                ),
              ],
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
                horizontal: MediaQuery.of(context).size.width / 40,
                vertical: MediaQuery.of(context).size.width / 120,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          _date.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
                child: Text(
                  "Date of Commission",
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
                horizontal: MediaQuery.of(context).size.width / 40,
                vertical: MediaQuery.of(context).size.width / 120,
              ),
              child: TextFormField(
                controller: _date1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Date of Commission";
                  } else {
                    return null;
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "dd-MM-yyyy",
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_outlined),
                      onPressed: () async {
                        DateTime? pickeddate1 = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1901),
                          lastDate: DateTime(2222),
                        );

                        if (pickeddate1 != null) {
                          setState(() {
                            _date1.text =
                                DateFormat('dd-MM-yyyy').format(pickeddate1);
                          });
                        }
                      }),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
                child: Text(
                  "Date of Retirement",
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
                horizontal: MediaQuery.of(context).size.width / 40,
                vertical: MediaQuery.of(context).size.width / 120,
              ),
              child: TextFormField(
                controller: _date2,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Date of Retirement";
                  } else {
                    return null;
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "dd-MM-yyyy",
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_outlined),
                      onPressed: () async {
                        DateTime? pickeddate2 = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1901),
                          lastDate: DateTime(2222),
                        );

                        if (pickeddate2 != null) {
                          setState(() {
                            _date2.text =
                                DateFormat('dd-MM-yyyy').format(pickeddate2);
                          });
                        }
                      }),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
                child: Text(
                  "PAN",
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
                horizontal: MediaQuery.of(context).size.width / 40,
                vertical: MediaQuery.of(context).size.width / 120,
              ),
              child: TextFormField(
                  controller: panNumber,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "PLEASE ENTER A 10 CHARACTER  VALID PAN",
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'([A-Z]{5}[0-9]{4}[A-Z]{1})')
                            .hasMatch(value)) {
                      return "Enter PAN";
                    } else {
                      return null;
                    }
                  }),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
                child: Text(
                  "Email",
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
                horizontal: MediaQuery.of(context).size.width / 40,
                vertical: MediaQuery.of(context).size.width / 120,
              ),
              child: TextFormField(
                controller: email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "EXAMPLE@GMAIL.COM",
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: MultiValidator([
                  MinLengthValidator(1, errorText: "Enter Email"),
                  EmailValidator(errorText: "Enter a valid Email"),
                ]),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 8.0, 150.0, 0.0),
                child: Text(
                  "MPIN",
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
                horizontal: MediaQuery.of(context).size.width / 40,
                vertical: MediaQuery.of(context).size.width / 120,
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _secureText,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "MPIN",
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _secureText ? Icons.visibility_off : Icons.visibility),
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
            Padding(
              // padding: const EdgeInsets.only(top: 20.0),
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (!isLoading)
                    ElevatedButton(
                      onPressed: () {
                        if (_FormKey.currentState!.validate()) {
                          doRegister();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF394361),
                      ),
                      child: const Text('Submit'),
                    ),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Help()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF394361),
                    ),
                    child: const Text('Help'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: AlertDialog(
                                title: Text(
                                    "You are going to cancel your registration. If you are okay with it, you can proceed."),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                        );
                                      },
                                      child: Text("Yes")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No")),
                                ],
                              ),
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF394361),
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
