import 'package:dr_plant/home.dart';
import 'package:dr_plant/homepage.dart';
import 'package:dr_plant/signup.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dr_plant/variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  var success = "";

  Future<void> _sendData() async {
    try {
      final response = await http.post(
        Uri.parse(url + 'login/'),
        headers: {'Content-Type': 'application/json'},
        body:
            json.encode({'username': _email.text, "password": _password.text}),
      );
      var responseData = json.decode(response.body);
      // print("res ------------- |||||||||||||||||| ${responseData}");

      print("[+] Response: " + responseData['success']);
      // var success = responseData['success'];
      setState(() {
        success = responseData['success'];
      });

      if (success == "yes") {
        print("worker =========");
        print(responseData['is_worker']);
        setState(() {
          username = _email.text;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          // print("object");
          return Home(
            loggedIn: true,
            username: _email.text,
            worker: responseData['is_worker'],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
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
                        "Welcome back",
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "HelveticaBold",
                            fontSize: 28),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Login in to your account !",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: "Helvetica",
                            fontSize: 16),
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
                        color: Color(0xFFf1f1f1),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Iconsax.user,
                            color: Colors.black.withOpacity(0.5),
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
                            hintText: "Username here",
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
                        color: Color(0xFFf1f1f1),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.lock,
                            color: Colors.black.withOpacity(0.5),
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
              if (success == "") SizedBox(height: 40),
              if (success == "no")
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Center(
                      child: Text(
                    "Invalid login credentials",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade400),
                  )),
                ),
              if (success == "yes")
                SizedBox(
                  height: 50,
                ),
              if (success == "no") SizedBox(height: 25),
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
                              "Login in to my account",
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
                height: 20,
              ),
              Center(
                  child: Text(
                "or",
                style: TextStyle(
                    fontFamily: "HelveticaBold",
                    color: Colors.black,
                    fontSize: 17),
              )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      print("object");
                      return Signup();
                    }));
                  },
                  child: FractionallySizedBox(
                    widthFactor: 0.90,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black.withOpacity(0.06),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Create a new account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "HelveticaBold",
                              color: Colors.black54,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
