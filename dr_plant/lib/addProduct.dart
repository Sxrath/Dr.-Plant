// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dr_plant/home.dart';
import 'package:flutter/material.dart';
import 'package:dr_plant/variables.dart';
// import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  bool invalid = false;

  bool isValidEmail(String email) {
    // define a regex pattern to match against
    final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    // create a RegExp object with the pattern
    final regExp = RegExp(pattern);

    // check if the email matches the pattern
    if (!regExp.hasMatch(email)) {
      return false;
    }

    return true;
  }

  var success = "";
  Future<void> _sendData() async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse(url + 'addProduct/'))
        ..headers.addAll({'Content-Type': 'multipart/form-data'})
        ..fields.addAll({
          'name': _name.text,
          'description': _desc.text,
          'price': _price.text,
        })
        ..files.add(await http.MultipartFile.fromPath('image', _image.path));

      final response = await http.Response.fromStream(await request.send());

      var responseData = json.decode(response.body);
      // print("res ------------- |||||||||||||||||| ${responseData}");

      print("[+] Response: " + responseData['success']);
      // var success = responseData['success'];
      setState(() {
        success = responseData['success'];
      });

      if (success == "yes") {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          // print("object");
          return Home(
            loggedIn: true,
            username: username,
          );
        }));
      }
      if (response.statusCode == 200) {
        print('Data sent successfully');

        // setState(() {
        //   _columns.insert(
        //       0,
        //       Comment(
        //         comment: _textController.text,
        //         sentiment: responseData,
        //         // sentiment:
        //         //     DateFormat('dd/MM/yy \'at\' hh:mm a').format(DateTime.now()),
        //       ));
        // });
        // setState(() {
        //   _textController.clear();
        // });
      } else {
        print('Failed to send data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  late XFile _image;

  Future sendImage() async {
    print("-------------->>>>>>>>>>>");
    var uri = Uri.parse(url + "image/");
    var request = http.MultipartRequest("POST", uri);
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      _image.path,
      contentType: MediaType('image', 'jpeg'),
    ));
    print(_image.path);
    // request.headers['X-CSRFToken'] = "csrfToken";
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  ImagePicker imagePicker = ImagePicker();

  Future selectImage() async {
    try {
      // ImagePicker imagePicker = ImagePicker();
      var image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _image = image;
          // sendImage();
        });
      }

      // for sending image
    } catch (e) {
      print(e);
    }
  }

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Signup",
          style: TextStyle(fontFamily: "HelveticaBold", color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 18,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              // ignore: prefer_const_constructors
              image: NetworkImage(
                  "https://img.freepik.com/free-vector/abstract-white-shapes-background_79603-1362.jpg?w=1060&t=st=1669829467~exp=1669830067~hmac=3ceebe026a3bf7da72bb45bdc755b1635be4d4e6fb32994884aaac5c00c059f0"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0), BlendMode.dstATop),
            ),
          ),
          child: ListView(
            children: [
              // SizedBox(height: 10),
              // Container(
              //   width: 190,
              //   height: 190,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage(
              //     "assets/avatars/112526-send-user.gif",
              //   ))),
              // ),
              Container(
                height: 220,
                // color: Colors.blue,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/avatars/profile.jpg"),
                        radius: 30,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Add Product",
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "HelveticaBold",
                            fontSize: 25),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Add your product now !",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: "HelveticaMedium",
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 0),

              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.all(0),
                width: 140,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Iconsax.document,
                            color: Colors.white,
                            size: 17,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        controller: _name,
                        decoration: InputDecoration(
                            hintText: "Product name",
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.all(0),
                width: 140,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.document_scanner_outlined,
                            color: Colors.white,
                            size: 17,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        controller: _desc,
                        decoration: InputDecoration(
                            hintText: "Product description",
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.all(0),
                width: 140,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.monetization_on,
                            color: Colors.white,
                            size: 17,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _price,
                        decoration: InputDecoration(
                            hintText: "Product price",
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: GestureDetector(
                  onTap: selectImage,
                  child: FractionallySizedBox(
                    widthFactor: 0.90,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // color:Colors.orange.shade600 was at first
                        color: Color.fromARGB(255, 235, 235, 235),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.add_circle,
                              color: Color.fromARGB(255, 33, 33, 33),
                              size: 18,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Choose Image",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "HelveticaBold",
                                  color: Color.fromARGB(255, 21, 21, 21),
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),

              Center(
                child: GestureDetector(
                  onTap: _sendData,
                  child: FractionallySizedBox(
                    widthFactor: 0.90,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // color:Colors.orange.shade600 was at first
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.add_circle,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Upload product",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "HelveticaBold",
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
