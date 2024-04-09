import 'package:dav2/screens/vet_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'mobile number.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    var code = "";
    return Scaffold(
      backgroundColor: Color(0xFFf2fcff),
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => Mobile()),
      //       );
      //     },
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     ),
      //   ),
      //   title: Text(
      //     "Verification",
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
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
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 25, right: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 150,),
                  Text(
                    "Verify your phone number",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    length: 6,
                    onChanged: (value) {
                      code = value;
                    },
                    // defaultPinTheme: defaultPinTheme,
                    // focusedPinTheme: focusedPinTheme,
                    // submittedPinTheme: submittedPinTheme,
                    // // validator: (s) {
                    // //   return s == '2222' ? null : 'Pin is incorrect';
                    // // },
                    // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    // onCompleted: (pin) => print(pin),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Enter your OTP code here",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: Mobile.verify, smsCode: code);

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );

                        } catch (e) {
                          print("wrong otp");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF0b0c5b),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28))),
                      // style: ElevatedButton.styleFrom(
                      //   primary: Color(0xFFa8d5e5),
                      // ),
                      child: Text(
                        "Verify phone number",
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   "Didn't you received any code?",
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       "RESEND NEW CODE",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black,
                  //       ),
                  //     )),
                ],
              ),
            ),
          ),

      ),
    );
  }
}
