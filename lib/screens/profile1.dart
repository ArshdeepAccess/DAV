import 'dart:convert';
import 'package:dav2/Models/pfofilenameModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'hmscreen1.dart';
import 'dart:async';
import 'dart:io';

class Profile1 extends StatefulWidget {
  const Profile1({Key? key}) : super(key: key);
  @override
  State<Profile1> createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {

  File? _image;
  Future<void> _selectImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _image = File(pickedFile!.path);
    });
    _uploadImage();
  }
  Future<void> _uploadImage() async {
    if (_image == null) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var serviceNumber = prefs.getString('ServiceNumber') ?? "";
    var cat = prefs.getString('Category') ?? "";

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseURL/PROFILE_PIC/PROFILE_PIC?UP_SERVICE_NO=$serviceNumber&UP_VAT_CAT=$cat&UP_PROFILE_PIC=Image/jpg'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'profilePicture',
        _image!.path,
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Profile picture uploaded successfully!');
    } else {
      print('Failed to upload profile picture.');
    }
  }

  late bool private_status;
  List<ProfilenameModel> data = [];
  bool _isEditable = false;
  bool _secureText = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var panController = TextEditingController();
  var aadharController = TextEditingController();
  var suffixController = TextEditingController();
  var dobController = TextEditingController();
  var docController = TextEditingController();
  var dodController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var categoryController = TextEditingController();
  var serviceNumberController = TextEditingController();
  var passwordController = TextEditingController();
  // List<LoginModel> data1 = [];
  // List<String> items = <String>['Officer', 'Airmen/NCs(E)'];
  // String dropDownValue = 'Officer';

  var serviceNumber = "";
  var category = "";
  var name = "";
  var pan = "";
  var aadhar = "";
  var suffix = "";
  var dob = "";
  var doc = "";
  var dod = "";
  var email = "";
  var mobile = "";

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
    getProfilePic();
    checkInternetConnection();
  }
  var newImage;

  Future<void> getProfilePic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var serviceNumber = prefs.getString('ServiceNumber') ?? "";
    var cat = prefs.getString('Category') ?? "";

    final response = await http.get(Uri.parse("$baseURL/PROFILE_PIC_VIEW/PROFILE_PIC_VIEW/?UP_SERVICE_NO=$serviceNumber&UP_VAT_CAT=$cat"));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var image = base64.decode(responseBody['items'][0]['up_profile_pic']);

      newImage = Image.memory(image, fit: BoxFit.fill,);
      setState(() {});
    }else{
      print(response.statusCode);
    }
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var serviceNumber = prefs.getString('ServiceNumber') ?? "";
    var cat = prefs.getString('Category') ?? "";

    final response = await http.get(Uri.parse(
        "${baseURL}/PROFILEDETAIL/PROFILEDETAIL/${serviceNumber}/${cat}"));
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Name', nameController.text);
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      data = (responseBody["items"] as List)
          .map((data) => ProfilenameModel.fromJson(data))
          .toList();
      print(data[0].av_name);
      prefs.setString("name", data[0].av_name);
      if (data[0].private_status == "true") {
        private_status = true;
      } else {
        private_status = false;
      }
      setState(() {
        nameController.text = data[0].av_name;
        serviceNumberController.text = data[0].user_service_no;
        // String a = data[0].user_pan_no;
        // String b = data[0].user_aadhar_no.toString();
        // if ( passwordController == true){
        //   panController.text = a;
        //   aadharController.text = b;
        // }
        // else{
        //   panController.text = maskPanNumber(a);
        //   aadharController.text =
        //       maskAadharNumber(b);
        // }
        panController.text = (data[0].user_pan_no);
        aadharController.text =
            (data[0].user_aadhar_no.toString());
        // panController.text = data[0].user_pan_no;
        // aadharController.text = data[0].user_aadhar_no.toString();
        suffixController.text = data[0].user_chk_suffix;
        dobController.text = data[0].user_dob;
        docController.text = data[0].user_doc;
        dodController.text = data[0].user_dod;
        emailController.text = data[0].user_email_id;
        mobileController.text = data[0].user_mob_no.toString();
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> doFlag(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var serviceNumberController = prefs.getString('ServiceNumber') ?? "";
    var cat = prefs.getString('Category') ?? "";

    print(
        "${baseURL}/UPDATE/PRIVACY_FLAG?SERVICE_NO=${serviceNumberController}&CATEGORY=${cat}&FLAG_YN=${value.toString()}"
            "&EMAIL=${emailController.text}&MOBILE=${mobileController.text.toString()}");

    final response = await http.put(
        Uri.parse(
            "${baseURL}/UPDATE/PRIVACY_FLAG?SERVICE_NO=${serviceNumberController}&CATEGORY=${cat}&FLAG_YN=${value.toString()}"
                "&EMAIL=${emailController.text}&MOBILE=${mobileController.text.toString()}"),
        body: {
          "SERVICE_NO": serviceNumberController,
          "CATEGORY": cat,
          "FLAG_YN": value.toString(),
          "EMAIL": emailController.text.toString(),
          "MOBILE": mobileController.text.toString(),
        });
    print(response.body);
    if (response.statusCode == 200) {
      print("ok");
    }
    _showMyDialog1("Record Updated Successfully");
  }

  Future<void> _showMyDialog1(message) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            // onPressed: () => Navigator.pop(context, 'OK'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  bool isLoading = true;
  bool isInternetConnection = true;
  void checkInternetConnection() async {
    bool internetConnection = await InternetConnectionChecker().hasConnection;
    if (internetConnection == true) {
      getData();
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
        automaticallyImplyLeading: false,
      //   actions: [
      // IconButton(
      // icon: Icon(Icons.arrow_back),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => HomeScreen()),
      //     );
      //   },
      // )
      //   ],
        backgroundColor: Color(0xFFd3eaf2),
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
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
      body: Form(
        key: formKey,
        child: ListView.separated(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
            shrinkWrap: true,
            primary: false,
            itemCount: data.length,
            separatorBuilder: (context, position) => const SizedBox(
              height: 10,
            ),
            itemBuilder: (context, position) {
              return Column(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhotoView(
                                imageProvider: _image != null
                                    ? FileImage(_image!)
                                    : newImage != null
                                    ? newImage.image
                                    : AssetImage('assets/images/placeholder.png'),
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Stack(
                            children: [
                              _image != null
                                  ? Image.file(
                                _image!,
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              )
                                  : newImage != null
                                  ? Image(
                                image: newImage.image,
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              )
                                  : Image.asset(
                                'assets/images/placeholder.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                top: 60,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () {
                                    _selectImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Stack(
                  //   children: [
                  //     _image == null ? Center(
                  //         child: SizedBox(
                  //           width: 100,
                  //           height: 100,
                  //           child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(100.0),
                  //               child: Container(color: Colors.grey)
                  //           ),
                  //         )
                  //     ) : Center(
                  //         child: SizedBox(
                  //             width: 100,
                  //             height: 100,
                  //             child: ClipRRect(
                  //                 borderRadius: BorderRadius.circular(100.0),
                  //                 child: Image.file(_image!, fit: BoxFit.fill)
                  //             )
                  //         )),
                  //     _image == null ? (
                  //         Center(
                  //             child: SizedBox(
                  //                 width: 100,
                  //                 height: 100,
                  //                 child: ClipRRect(
                  //                     borderRadius: BorderRadius.circular(100.0),
                  //                     child: newImage
                  //                 )
                  //             ))) : Container(),
                  //
                  //     Positioned(
                  //       top: 60,
                  //       right: 110,
                  //       child: IconButton(
                  //         icon: Icon(Icons.camera_alt),
                  //         onPressed: () {
                  //           _selectImage();
                  //         },
                  //       ),
                  //     ),   ],
                  // ),
                  SizedBox(
                    // height: 15,
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      readOnly: true,
                      controller: nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusColor: Colors.transparent,
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 15,
                    height: size.height * 0.01,
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
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 15,
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      readOnly: true,
                      controller: suffixController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusColor: Colors.transparent,
                        labelText: 'Check Suffix',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   // height: 15,
                  //   height: size.height * 0.01,
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: Text(
                  //           "Do you want to see your full PAN & Aadhar Number.Then click on MPIN button",
                  //           style: TextStyle(
                  //               color: Color(0xFF0b0c5b),
                  //               fontWeight: FontWeight.bold),
                  //         )),
                  //     Column(
                  //       children: [
                  //         ElevatedButton(
                  //           // onPressed: () {
                  //           //   Navigator.push(
                  //           //     context,
                  //           //     MaterialPageRoute(builder: (context) => Mpin()),
                  //           //   );
                  //           // },
                  //           onPressed: () => _showMPINVerificationDialog(),
                  //
                  //           style: ElevatedButton.styleFrom(
                  //             primary: const Color(0xFF394361),
                  //           ),
                  //
                  //           child: const Text('MPIN'),
                  //         ),
                  //
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    // height: 15,
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      readOnly: true,
                      enabled: _isEditable,
                      controller: panController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusColor: Colors.transparent,
                        labelText: 'Pan',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.01,
                    // height: 15,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      enabled: _isEditable,
                      readOnly: true,
                      controller: aadharController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusColor: Colors.transparent,
                        labelText: 'Aadhar',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                    // height: 15,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      readOnly: true,
                      controller: dobController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusColor: Colors.transparent,
                        labelText: 'DOB',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                    // height: 15,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      readOnly: true,
                      controller: docController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusColor: Colors.transparent,
                        labelText: 'DOC',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                    // height: 15,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      readOnly: true,
                      controller: dodController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusColor: Colors.transparent,
                        labelText: 'DOD',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   // height: 40,
                  //   height: size.height * 0.05,
                  //   child: TextFormField(
                  //     readOnly: true,
                  //     controller: dodController,
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       labelText: 'DOD',
                  //       // filled: true,
                  //       // fillColor: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            "Allow to hide your mobile no. & email from your coursemates",
                            style: TextStyle(
                                color: Color(0xFF0b0c5b),
                                fontWeight: FontWeight.bold),
                          )),
                      Column(
                        children: [
                          Switch(
                            value: private_status,
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.grey.shade400,
                            onChanged: (value) {
                              print(doFlag(value));
                              doFlag(value);
                              setState(() {
                                private_status = value;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                    // height: 15,
                  ),
                  SizedBox(
                    // height: 40,
                    height: size.height * 0.06,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          // child: TextFormField(
                          //   readOnly: false,
                          //   controller: emailController,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please enter your email';
                          //     } else if (!RegExp(
                          //             r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          //         .hasMatch(value)) {
                          //       return 'Please enter a valid email';
                          //     }
                          //     return null;
                          //   },
                          //   enabled: _isEditable,
                          //   decoration: const InputDecoration(
                          //     border: OutlineInputBorder(),
                          //     labelText: 'Email Id',
                          //   ),
                          // ),
                          child: TextFormField(
                            readOnly: false,
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            enabled: _isEditable,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusColor: Colors.transparent,
                              labelText: 'Email Id',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              emailController.text = "";
                              _isEditable = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                    // height: 15,
                  ),
                  SizedBox(
                    // height: 40,
                    height: size.height * 0.06,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: TextFormField(
                            readOnly: false,
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              final phoneRegExp = RegExp(r'^\d{10}$');
                              if (!phoneRegExp.hasMatch(value)) {
                                return 'Please enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                            enabled: _isEditable,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusColor: Colors.transparent,
                              labelText: 'Mobile Number',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              mobileController.text = "";
                              _isEditable = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        doFlag(isLoading);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF394361),
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
