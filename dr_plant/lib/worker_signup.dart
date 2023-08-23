// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dr_plant/home.dart';
import 'package:flutter/material.dart';
import 'package:dr_plant/variables.dart';
// import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class WorkerSignup extends StatefulWidget {
  const WorkerSignup({Key? key}) : super(key: key);

  @override
  State<WorkerSignup> createState() => _WorkerSignupState();
}

class _WorkerSignupState extends State<WorkerSignup> {
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
  bool empty = false;
  Future<void> _sendData() async {
    var valid = isValidEmail(_email.text);
    if (valid) {
      invalid = false;
      if (_username.text != "" &&
          _password.text != "" &&
          _addhaar.text != "" &&
          _firstname.text != "" &&
          _lastname.text != "") {
        try {
          final response = await http.post(
            Uri.parse(url + 'registerWorker/'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'username': _username.text,
              "password": _password.text,
              "email": _email.text,
              "firstname": _firstname.text,
              "lastname": _lastname.text,
              "adhaar": _addhaar.text
            }),
          );
          var responseData = json.decode(response.body);
          // print("res ------------- |||||||||||||||||| ${responseData}");

          print("[+] Response: " + responseData['success']);
          // var success = responseData['success'];
          setState(() {
            success = responseData['success'];
            empty = false;
          });

          if (success == "yes") {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              // print("object");
              return Home(
                loggedIn: false,
                username: "Guest User",
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
      } else {
        setState(() {
          empty = true;
        });
      }
    } else {
      setState(() {
        invalid = true;
      });
    }
  }

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  final _addhaar = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
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
                        "Hey there",
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "HelveticaBold",
                            fontSize: 25),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Create your new account !",
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
                            Icons.person_add,
                            color: Colors.white,
                            size: 17,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        controller: _firstname,
                        decoration: InputDecoration(
                            hintText: "Firstname",
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
                            Icons.person_add_alt_rounded,
                            color: Colors.white,
                            size: 17,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        controller: _lastname,
                        decoration: InputDecoration(
                            hintText: "Lastname",
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
                            Icons.mail,
                            color: Colors.white,
                            size: 17,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        controller: _email,
                        decoration: InputDecoration(
                            hintText: "Email address",
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
                            Icons.person,
                            color: Colors.white,
                            size: 17,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        controller: _username,
                        decoration: InputDecoration(
                            hintText: "Username",
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
                            Icons.contact_mail,
                            color: Colors.white,
                            size: 17,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        controller: _addhaar,
                        decoration: InputDecoration(
                            hintText: "Adhaar number",
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
                            Icons.lock,
                            color: Colors.white,
                            size: 17,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        obscureText: true,
                        controller: _password,
                        decoration: InputDecoration(
                            hintText: "Password",
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
              if (!invalid && success == "")
                SizedBox(
                  height: 50,
                ),

              if (success == "no")
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Center(
                      child: Text(
                    "Username already exists",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade400),
                  )),
                ),
              if (empty)
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Center(
                      child: Text(
                    "Please fill all the fields",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade400),
                  )),
                ),
              if (invalid)
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Center(
                      child: Text("Invalid email address",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600))),
                ),
              SizedBox(
                height: 20,
              ),
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
                              Iconsax.login,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Create a new account",
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
