// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable

// import 'package:depression/banner.dart';

import 'package:dr_plant/blogCard.dart';
import 'package:dr_plant/login.dart';
import 'package:dr_plant/signup.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
// import 'package:depression/variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dr_plant/variables.dart';

class Blog extends StatefulWidget {
  final bool login;
  const Blog({
    Key? key,
    required this.login,
  }) : super(key: key);

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  void navigateToLogin(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      print("object");

      return Login();
    }));
  }

  bool loggedIn = false;

  void setLogin() {
    setState(() {
      loggedIn = widget.login;
    });
  }

  // TODO: implement setState

  void navigateToSignup(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      print("object");

      // loggedIn = true;
      print(loggedIn);
      return Signup();
    }));
  }

  List<ProductTop> productsTop = [];

  Future<void> getData() async {
    final response = await http.get(Uri.parse(url + 'blog/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        productsTop = data.map((prod) => ProductTop.fromJson(prod)).toList();
      });
      print(productsTop);
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  @override
  void initState() {
    super.initState();
    setLogin();
    getData();
    print(loggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blogs",
          style: TextStyle(fontFamily: "HelveticaBold", color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        // leading: Icon(
        //   Icons.arrow_back_ios_new_rounded,
        //   color: Colors.grey,
        // ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            SizedBox(height: 0),
            // Days(),

            // Text(loggedIn ? 'Welcome!' : 'Please log in'),

            for (var product in productsTop)
              BlogCard(
                  name: product.name,
                  image: product.image,
                  pk: product.pk,
                  description: product.description,
                  date: product.date),
            // BlogCard(),
            // Video()
          ],
        ),
      ),
    );
  }
}

class ProductTop {
  final String name;
  final String description;
  final String image;
  final String date;
  final String pk;

  ProductTop({
    required this.name,
    required this.description,
    required this.image,
    required this.pk,
    required this.date,
  });

  factory ProductTop.fromJson(Map<String, dynamic> json) {
    return ProductTop(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      pk: json['pk'],
      date: json['date'],
    );
  }
}
