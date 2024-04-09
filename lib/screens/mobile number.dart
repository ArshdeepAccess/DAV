import 'package:auto_size_text/auto_size_text.dart';
import 'package:dav2/screens/vet_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'VeteransLogin.dart';
import 'otp.dart';

class Mobile extends StatefulWidget {
  const Mobile({Key? key}) : super(key: key);
  static String verify = "";
  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  TextEditingController countrycode = TextEditingController();
  var phone = "";
  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

  Widget build(BuildContext context) {
    final maxLines;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFf2fcff),
      appBar: AppBar(
        // backgroundColor: Color(0xFFd3eaf2),
        backgroundColor: const Color(0xFF394361),
        elevation: 0,
        title: Text(
          "VAYU-SAMPARC",
          style: TextStyle(
            // color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width / 20, 0, 20, 0),
            child: Column(
              children: [
                SizedBox(
                  // height: 20,
                  height: size.height * 0.05,
                ),
                Image(
                    height: size.height * 0.25,
                    // width: size.width*,
                    image: AssetImage("assets/images/my_small_icon.png")),
                SizedBox(
                  // height: 20,
                  height: size.height * 0.02,
                ),
                Row(

                  children: [
                    Expanded(
                      child: Text(
                        "Sign Up to VAYU-SAMPARC",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "Add your mobile number.We'll send you a verification code so we know you are real.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  // height: 20,
                  height: size.height * 0.02,
                ),


                Container(
                  height: size.height * 0.07,
                  // height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                    phone = value;
                      },
                      decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Mobile Number"),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  // height: 20,
                ),
                SizedBox(
                  // height: 45,
                  height: size.height * 0.06,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countrycode.text + phone}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          Mobile.verify = verificationId;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Otp()),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );

                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF0b0c5b),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28))),
                    child: Text(
                      "SEND OTP",
                    ),
                  ),
                ),
                SizedBox(
                  // height: 10,
                  height: size.height * 0.03,
                ),
              Text(
                  "By providing my mobile number,I hereby agree and accept the Terms of Service and Privacy policy in use of the app.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),

                  textAlign: TextAlign.center,
                ),
                // SizedBox(
                //   height: size.height * 0.03,
                //   // height: 20,
                // ),
                // SizedBox(
                //   // height: 45,
                //   height: size.height * 0.06,
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(builder: (context) => Register()),
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //         primary: const Color(0xFF0b0c5b),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(28))),
                //     child: Text(
                //       "Skip for now",
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
      ),
    );
  }
}
