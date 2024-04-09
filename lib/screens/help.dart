import 'package:flutter/material.dart';
class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFf2fcff),
      appBar: AppBar(
        backgroundColor: Color(0xFF394361),
        title: Text(
          "Steps to Register",
          style: TextStyle(fontSize: 20),
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5,4,2,2),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(child: Text("1. Select your category from Dropdown menu.")),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text("2. Enter your Service number.")),
                ],
              ),      SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text("3. Enter your Aadhar number.")),
                ],
              ),      SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text("4. Enter your Mobile number.Then click on OTP button."
                      " An OTP Screen will open.Enter your OTP there"
                      " and click on verify mobile number.")),
                ],
              ),   SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text("5. Enter your DOB.")),
                ],
              ),   SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text("6. Enter your Date of Commission.")),
                ],
              ),   SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text("7. Enter your Date of Retirement.")),
                ],
              ),   SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text("8. Enter your PAN.")),
                ],
              ),   SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text("9. Enter your email.")),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text("10. Enter a MPIN.")),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text("11. Then click on Submit Button.")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
