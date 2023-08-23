// ignore_for_file: unused_import, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:dr_plant/blog.dart';
import 'package:dr_plant/login.dart';
import 'package:dr_plant/signup.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:depression/login.dart';
// import 'package:depression/music.dart';
// import 'package:depression/signup.dart';
// import 'package:depression/videos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:dr_plant/variables.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SubsidyView extends StatefulWidget {
  final name;
  final category;
  final price;
  final comments;
  final image;
  final description;
  final pk;
  const SubsidyView({
    this.name,
    this.category,
    this.price,
    this.comments,
    this.image,
    this.description,
    this.pk,
    Key? key,
  }) : super(key: key);

  @override
  State<SubsidyView> createState() => _SubsidyViewState();
}

class _SubsidyViewState extends State<SubsidyView> {
  final _textController = TextEditingController();

  void navigateToLogin(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      print("object");
      return Login();
    }));
  }

  void navigateToSignup(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      print("object");
      return Signup();
    }));
  }

  void goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  List<ProductBottom> productsBottom = [];

  Future<void> getDataBottom() async {
    final response = await http.get(Uri.parse(url + 'productsBottom/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        productsBottom =
            data.map((prod) => ProductBottom.fromJson(prod)).toList();
      });
      print(productsBottom);
    } else {
      throw Exception('Failed to load plants');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Blog",
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
        body: Padding(
          padding: const EdgeInsets.only(left: 0, bottom: 10, top: 10),
          child: ListView(
            children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: Column(
                  children: [
                    Container(
                      // width: 240,
                      // height: 380,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 0),
                          Center(
                            child: Image.network(
                              widget.image,
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 20, right: 15),
                                  child: Text(
                                    widget.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1.5,
                                        fontFamily: "HelveticaBold",
                                        fontSize: 22,
                                        color: Colors.black87),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Center(
                                  child: Text(
                                    widget.description,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        height: 1.9,
                                        fontSize: 15,
                                        fontFamily: "HelveticaMedium",
                                        color:
                                            Color.fromARGB(255, 100, 100, 100)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          goBack(context);
                        },
                        child: FractionallySizedBox(
                          widthFactor: 0.90,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              // color:Colors.orange.shade600 was at first
                              color: Color.fromARGB(255, 233, 233, 233),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Color.fromARGB(255, 37, 37, 37),
                                    size: 18,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    "Go Back To Subsidies",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "HelveticaBold",
                                        color: Color.fromARGB(255, 35, 35, 35),
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    SizedBox(height: 10),
                    Column(
                      children: [],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class ProductBottom {
  final String name;
  final String price;
  final String image;
  final String comments;
  final String description;
  final String category;

  ProductBottom(
      {required this.name,
      required this.price,
      required this.image,
      required this.comments,
      required this.category,
      required this.description});

  factory ProductBottom.fromJson(Map<String, dynamic> json) {
    return ProductBottom(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      comments: json['comments'],
      category: json['category'],
      description: json['description'],
    );
  }
}

class CommentDisplay {
  final String text;
  final String sentiment;

  CommentDisplay({
    required this.text,
    required this.sentiment,
  });

  factory CommentDisplay.fromJson(Map<String, dynamic> json) {
    return CommentDisplay(
      text: json['text'],
      sentiment: json['sentiment'],
    );
  }
}
