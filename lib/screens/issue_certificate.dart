import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class Issue extends StatefulWidget {
  const Issue({Key? key}) : super(key: key);

  @override
  State<Issue> createState() => _IssueState();
}

class _IssueState extends State<Issue> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var serviceNumberController = TextEditingController();
  var rankController = TextEditingController();
  var pponoController = TextEditingController();
  var firstnameController = TextEditingController();
  var middlenameController = TextEditingController();
  var lastnameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();

  String dropdownValue = 'Option 1';
  File? _pdf;

  // void _viewPdf() async {
  //   if (_pdf != null) {
  //     // Open the selected PDF file
  //     await OpenFile.open(_pdf!.path);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Request for welfare issue",
                // textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF0b0c5b),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.05,
              child: TextFormField(
                readOnly: true,
                controller: serviceNumberController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusColor: Colors.transparent,
                  labelText: 'Service Number',
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.05,
              child: TextFormField(
                readOnly: true,
                controller: rankController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusColor: Colors.transparent,
                  labelText: 'Rank',
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.05,
              child: TextFormField(
                readOnly: true,
                controller: pponoController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusColor: Colors.transparent,
                  labelText: 'PPO NO',
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.05,
              child: TextFormField(
                readOnly: true,
                controller: firstnameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusColor: Colors.transparent,
                  labelText: 'First Name',
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.05,
              child: TextFormField(
                readOnly: true,
                controller: middlenameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusColor: Colors.transparent,
                  labelText: 'Middle Name',
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.05,
              child: TextFormField(
                readOnly: true,
                controller: lastnameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusColor: Colors.transparent,
                  labelText: 'Last Name',
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.05,
              child: TextFormField(
                readOnly: true,
                controller: mobileController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusColor: Colors.transparent,
                  labelText: 'Mobile Number',
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.05,
              child: TextFormField(
                readOnly: true,
                controller: emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusColor: Colors.transparent,
                  labelText: 'Email ID',
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Text(
            //     "Request for Certificate",
            //     // textAlign: TextAlign.right,
            //     style: TextStyle(
            //       color: Color(0xFF0b0c5b),
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Card(
              // color: Color(0xffddedf3),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: screenHeight * 0.9,
                  width: screenWidth * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welfare issue Certificate"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // set the color of the border
                            width: 1, // set the width of the border
                          ),
                          borderRadius: BorderRadius.circular(
                              10), // set the circular border radius
                        ),
                        width: 300, // set the width of the dropdown
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          underline: Container(),
                          items: <String>[
                            'Option 1',
                            'Option 2',
                            'Option 3',
                            'Option 4'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Correspondence Address Line 1"),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (text) {
                          // handle text input
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Correspondence Address Line 2"),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (text) {
                          // handle text input
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Country"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // set the color of the border
                            width: 1, // set the width of the border
                          ),
                          borderRadius: BorderRadius.circular(
                              10), // set the circular border radius
                        ),
                        width: 300, // set the width of the dropdown
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          underline: Container(),
                          items: <String>[
                            'Option 1',
                            'Option 2',
                            'Option 3',
                            'Option 4'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("State"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // set the color of the border
                            width: 1, // set the width of the border
                          ),
                          borderRadius: BorderRadius.circular(
                              10), // set the circular border radius
                        ),
                        width: 300, // set the width of the dropdown
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          underline: Container(),
                          items: <String>[
                            'Option 1',
                            'Option 2',
                            'Option 3',
                            'Option 4'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("City"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // set the color of the border
                            width: 1, // set the width of the border
                          ),
                          borderRadius: BorderRadius.circular(
                              10), // set the circular border radius
                        ),
                        width: 300, // set the width of the dropdown
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          underline: Container(),
                          items: <String>[
                            'Option 1',
                            'Option 2',
                            'Option 3',
                            'Option 4'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Pin"),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (text) {
                          // handle text input
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Help()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF394361),
                  ),
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Help()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF394361),
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Upload Supporting Document",
              // textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF0b0c5b),
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text("Upload Certificate"),
                    content: _pdf == null
                        ? Text("Please select a PDF to upload")
                        : Row(
                      children: [
                        Expanded(
                          child: Text("Selected PDF: ${_pdf!.path}"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_pdf!= null) {
                              await OpenFile.open(_pdf!.path);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF394361),
                          ),
                          child: Text("View"),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text("Cancel",),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      TextButton(
                        child: Text("Select PDF"),
                        onPressed: () async {
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );
                          if (result != null) {
                            setState(() {
                              _pdf = File(result.files.single.path!);
                            });
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF394361),
              ),
              child: Text("Document for Welfare issue Certificate"),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
