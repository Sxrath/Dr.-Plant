import 'package:dr_plant/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(
      loggedIn: false,
      username: "",
      worker: "False",
    ),
  ));
}
