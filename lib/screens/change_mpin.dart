import 'package:dav2/screens/hmscreen1.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';

class ChangeMpin extends StatefulWidget {
  const ChangeMpin({Key? key}) : super(key: key);

  @override
  State<ChangeMpin> createState() => _ChangeMpinState();
}

class _ChangeMpinState extends State<ChangeMpin> {
  bool _secureText = true;

  var newmpinController = TextEditingController();

  void initState() {
    super.initState();
    // checkInternetConnection();
  }

  Future<void> doMpin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var serviceNumberController = prefs.getString('ServiceNumber') ?? "";
    var cat = prefs.getString('Category') ?? "";

    print(
        "${baseURL}/UPDATEMPIN/UPDATEMPIN?SERVICE_NO=${serviceNumberController}&CATEGORY=${cat}&MPIN=${newmpinController.text.toString()}");

    final response = await http.put(
        Uri.parse(
            "${baseURL}/UPDATEMPIN/UPDATEMPIN?SERVICE_NO=${serviceNumberController}&CATEGORY=${cat}&MPIN=${newmpinController.text.toString()}"),
        body: {
          "SERVICE_NO": serviceNumberController,
          "CATEGORY": cat,
          "MPIN": newmpinController.text.toString(),
        });
    print(response.body);
    if (response.body.trim() == "OK") {
      prefs.setString('MPIN', newmpinController.text.toString());
      _showMyDialog1("MPIN Updated Successfully");
      // Fluttertoast.showToast(msg: "MPIN Changed Successfully");
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      _showMyDialog(response.body);
    }
  }

  Future<void> _showMyDialog1(message) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            ),
            // Navigator.pop(context, 'OK'),
            // child: const Text('OK'),
            child: const Text('OK'),
          )
        ],
      ),
    );
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

  // bool isLoading = true;
  // bool isInternetConnection = true;
  // void checkInternetConnection()async{
  //   bool internetConnection = await InternetConnectionChecker().hasConnection;
  //   if(internetConnection == true)
  //   {
  //     doMpin();
  //   }
  //   else
  //   {
  //     setState(() {
  //       isInternetConnection = false;
  //     });
  //     _showMyDialog1("Please check your internet connectivity");
  //   }
  //
  //
  // }
  // Future<void> _showMyDialog1(message) async {
  //   showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text('No Connection'),
  //       content: Text(message),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, 'OK'),
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
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
      ),
      body: ListView(children: [
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "New Mpin",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF0b0c5b),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 40,
            vertical: MediaQuery.of(context).size.width / 120,
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

          // child: TextFormField(
          //   controller: newmpinController,
          //   // length: 4,
          //   obscureText: true,
          //   obscuringCharacter: '●',
          //   onChanged: (value) {
          //     setState(() {
          //       _secureText = !_secureText;
          //     });
          //   },
          //   showCursor: true,
          // ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          height: size.height * 0.06,
          // height: 50,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              doMpin();
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
