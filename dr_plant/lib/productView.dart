// ignore_for_file: unused_import, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:dr_plant/login.dart';
import 'package:dr_plant/products.dart';
import 'package:dr_plant/shop.dart';
import 'package:dr_plant/signup.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dr_plant/variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'dart:core';
import 'package:intl/intl.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductView extends StatefulWidget {
  final name;

  final price;

  final image;
  final description;
  final type;
  final pk;

  const ProductView({
    this.name,
    this.price,
    this.image,
    this.description,
    this.type,
    this.pk,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
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

  // var url = 'http://192.168.0.8:8000/';

  List<PlantView> plants = [];
  var i = 0;
  Future<void> getData() async {
    final response = await http.get(Uri.parse(url + 'plants/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        plants = data.map((plant) => PlantView.fromJson(plant)).toList();
      });
      print(plants[1].description);
    } else {
      throw Exception('Failed to load plants');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.name,
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
          actions: [
            // GestureDetector(
            //   onTap: () {
            //     navigateToLogin(context);
            //   },
            //   child: CircleAvatar(
            //     radius: 18,
            //     backgroundColor: Colors.black.withOpacity(0.05),
            //     child: Container(
            //       // width: 25,
            //       // height: 25,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(100),
            //         // color: Colors.black.withOpacity(0.1),
            //       ),
            //       child: Icon(
            //         Iconsax.login,
            //         color: Colors.black,
            //         size: 16,
            //       ),
            //     ),
            //   ),
            // ),
            // CircleAvatar(
            //   radius: 18,
            //   backgroundImage: AssetImage("assets/avatars/strangerThings.jpg"),
            // ),
            // SizedBox(
            //   width: 20,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     navigateToSignup(context);
            //   },
            //   child: CircleAvatar(
            //     radius: 18,
            //     backgroundColor: Colors.black.withOpacity(0.05),
            //     child: Container(
            //       // width: 25,
            //       // height: 25,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(100),
            //         // color: Colors.black.withOpacity(0.1),
            //       ),
            //       child: Icon(
            //         Iconsax.user_add,
            //         color: Colors.black,
            //         size: 16,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 0, bottom: 0, top: 10),
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
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15),
                              Center(
                                child: Image.network(
                                  widget.image,
                                  width: 250,
                                  height: 250,
                                  // fit: BoxFit.contain,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0, top: 20),
                                      child: Text(
                                        widget.name,
                                        style: TextStyle(
                                            fontFamily: "HelveticaBold",
                                            fontSize: 20,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0, top: 15),
                                      child: Text(
                                        widget.price,
                                        style: TextStyle(
                                            fontFamily: "Helvetica",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Color.fromARGB(221, 49, 161, 70)
                                                    .withOpacity(1)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: Center(
                                      child: Text(
                                        widget.description,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(height: 1.8),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.90,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color:Colors.orange.shade600 was at first
                            color: Color.fromARGB(221, 49, 161, 70),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.money,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Buy now for ₹ ${widget.price}",
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
                    SizedBox(height: 20),
                    // Center(
                    //   child: FractionallySizedBox(
                    //     widthFactor: 0.90,
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(5),
                    //         // color:Colors.orange.shade600 was at first
                    //         color: Color.fromARGB(255, 239, 239, 239),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(14.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Icon(
                    //               Iconsax.shopping_cart,
                    //               color: Colors.black,
                    //               size: 18,
                    //             ),
                    //             SizedBox(width: 15),
                    //             Text(
                    //               "Add this item to cart",
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                   fontFamily: "HelveticaBold",
                    //                   color: Colors.black,
                    //                   fontSize: 17),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "New plants 🪴",
                      style: TextStyle(
                          fontFamily: "HelveticaBold",
                          fontSize: 17,
                          color: Colors.black87),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          print("object");
                          return Shop();
                        }));
                      },
                      child: Text(
                        "view all",
                        style: TextStyle(
                            fontFamily: "HelveticaMedium",
                            fontSize: 15,
                            color: Color(0xFFd2833e)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 330,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var plant in plants)
                      Product(
                        name: plant.name,
                        image: plant.image,
                        price: "\$ ${plant.price}",
                        description: plant.description,
                      ),
                    // Product(
                    //   name: "Junipor Bonsai",
                    //   image: "assets/avatars/plant8.png",
                    //   comments: "8",
                    //   price: "\$ 19.00",
                    //   category: "Headset",
                    // ),
                    // Product(
                    //   name: "Color Orchids",
                    //   image: "assets/avatars/plant9.png",
                    //   comments: "8",
                    //   price: "\$ 11.00",
                    //   category: "Headset",
                    // ),
                    // Product(
                    //   name: "Elm Bonsai",
                    //   image: "assets/avatars/plant10.png",
                    //   comments: "8",
                    //   price: "\$ 22.00",
                    //   category: "Headset",
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 50,
                color: Color.fromARGB(255, 37, 41, 42),
                child: Center(
                    child: Text(
                  "Thanks for visiting",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "HelveticaBold",
                    fontSize: 15,
                  ),
                )),
              )
            ],
          ),
        ));
  }
}

class PlantView {
  final String name;
  final double price;
  final String image;
  final String description;

  PlantView({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  factory PlantView.fromJson(Map<String, dynamic> json) {
    return PlantView(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      description: json['description'],
    );
  }
}
