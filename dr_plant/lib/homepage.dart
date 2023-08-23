// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import, avoid_print, unused_field, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:dr_plant/addProduct.dart';
import 'package:dr_plant/cards.dart';
import 'package:dr_plant/categories.dart';
import 'package:dr_plant/crops.dart';
import 'package:dr_plant/login.dart';
import 'package:dr_plant/products.dart';
import 'package:dr_plant/search.dart';
import 'package:dr_plant/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dr_plant/variables.dart';
import 'package:weather/weather.dart';

class Homepage extends StatefulWidget {
  final bool login;
  final username;
  final worker;
  const Homepage({Key? key, required this.login, this.username, this.worker})
      : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

var user = "Guest user";
final _query = TextEditingController();

class _HomepageState extends State<Homepage> {
  bool loggedIn = false;
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

  List<Search> searchPlants = [];
  void _sendQuery() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      print("object");
      return SearchResult(
        query: _query.text,
      );
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

  List<PlantViewTop> topPlants = [];

  Future<void> getTopPlants() async {
    final response = await http.get(Uri.parse(url + 'plantsTop/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        topPlants = data.map((plant) => PlantViewTop.fromJson(plant)).toList();
      });
      print(topPlants[1].name);
    } else {
      throw Exception('Failed to load plants');
    }
  }

  List<PlantViewBottom> bottomPlants = [];

  Future<void> getBottomPlants() async {
    final response = await http.get(Uri.parse(url + 'plantsBottom/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        bottomPlants =
            data.map((plant) => PlantViewBottom.fromJson(plant)).toList();
      });
      print(bottomPlants[1].name);
    } else {
      throw Exception('Failed to load plants');
    }
  }

  Future<void> logout() async {
    final response = await http.get(Uri.parse(url + 'logout/'));
    if (response.statusCode == 200) {
      // String<dynamic> data = json.decode(response.body);
      setState(() {
        loggedIn = false;
        worker = "false";
      });

      setState(() {
        user = "Guest user";
      });
      // print(productsTop);
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  var weather;

  // Future<void> getWeather() async {
  //   print('object');
  //   double lat = 55.0111;
  //   double lon = 15.0569;
  //   String key = '856822fd8e22db5e1ba48c0e7d69844a';
  //   String cityName = 'kochi';
  //   WeatherFactory wf = WeatherFactory(key);
  //   print("===========||||||||||||||||");
  //   Weather w = await wf.currentWeatherByCityName(cityName);
  //   print(w.temperature);
  //   if (w.temperature != null) {
  //     setState(() {
  //       weather = w.temperature.toString();
  //     });
  //   } else {
  //     weather = 32;
  //     // handle null temperature value
  //   }
  // }

  var worker = "false";

  @override
  void initState() {
    super.initState();
    getData();
    getTopPlants();
    getBottomPlants();
    setState(() {
      loggedIn = widget.login;
      user = widget.username;
      worker = widget.worker;
    });
    print("========== login");
    print(loggedIn);
    // try {
    //   getWeather();
    // } catch (e) {
    //   setState(() {
    //     weather = "Not available";
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0XFFC72C41),
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 58.0, top: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Detected : Rot",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20)),
                                child: SvgPicture.asset(
                                  "assets/avatars/bubbles.svg",
                                  height: 48,
                                  width: 40,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      duration: Duration(days: 365),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/avatars/profile.jpg"),
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, ",
                    style: TextStyle(
                        fontFamily: "HelveticaMedium",
                        color: Colors.black45,
                        fontSize: 13),
                  ),
                  SizedBox(height: 2),
                  Text(
                    user,
                    style: TextStyle(
                        fontFamily: "HelveticaBold", color: Colors.black),
                  )
                ],
              )
            ],
          ),
        ),
        actions: [
          if (!loggedIn)
            Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: GestureDetector(
                onTap: () {
                  navigateToLogin(context);
                },
                child: Icon(
                  Iconsax.login,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ),
          if (!loggedIn)
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: GestureDetector(
                onTap: () {
                  navigateToSignup(context);
                },
                child: Icon(
                  Iconsax.user_add,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ),
          if (loggedIn)
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    print("object");
                    return Crop(
                      login: false,
                    );
                  }));
                },
                child: Icon(
                  Iconsax.calendar,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ),
          if (worker == "True")
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    print("object");
                    return AddProduct();
                  }));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ),
          if (loggedIn)
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: GestureDetector(
                onTap: () {
                  logout();
                },
                child: Icon(
                  Iconsax.logout,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Weather",
                    style: TextStyle(
                        fontFamily: "HelveticaBold",
                        fontSize: 17,
                        color: Colors.black87),
                  ),
                  Text(
                    "Thrissur",
                    style: TextStyle(
                        fontFamily: "HelveticaMedium",
                        fontSize: 15,
                        color: Color(0xFFd2833e)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sunny,
                  size: 30,
                  color: Color.fromARGB(255, 167, 153, 28),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "32 C",
                  style: TextStyle(fontFamily: "HelveticaBold", fontSize: 20),
                )
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 13.0, right: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.92,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          controller: _query,
                          autofocus: false,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 14),
                              filled: true,
                              hintStyle: TextStyle(
                                  fontFamily: "HelveticaMedium",
                                  fontWeight: FontWeight.w500),
                              enabledBorder: InputBorder.none,
                              fillColor: Colors.black.withOpacity(0.04),
                              hintText: "search plants",
                              prefixIcon: Icon(
                                Iconsax.search_normal,
                                size: 16,
                              ),
                              focusedBorder: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _sendQuery,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 47,
                        height: 47,
                        color: Colors.green,
                        child: Icon(
                          Icons.search_rounded,
                          size: 19,
                          semanticLabel: "Search",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // SizedBox(
            //   height: 90,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [Categories()],
            //   ),
            // ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Top Plants",
                    style: TextStyle(
                        fontFamily: "HelveticaBold",
                        fontSize: 17,
                        color: Colors.black87),
                  ),
                  Text(
                    "view all",
                    style: TextStyle(
                        fontFamily: "HelveticaMedium",
                        fontSize: 15,
                        color: Color(0xFFd2833e)),
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
                      pk: plant.pk,
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "New plants  🪴",
                    style: TextStyle(
                        fontFamily: "HelveticaBold",
                        fontSize: 17,
                        color: Colors.black87),
                  ),
                  Text(
                    "view all",
                    style: TextStyle(
                        fontFamily: "HelveticaMedium",
                        fontSize: 15,
                        color: Color(0xFFd2833e)),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var plant in topPlants)
                  Flexible(
                    child: PlantCard(
                      name: plant.name,
                      image: plant.image,
                      comments: "8",
                      price: "\$ ${plant.price}",
                      category: "Headset",
                      description: plant.description,
                    ),
                  ),
                SizedBox(width: 10)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var plant in bottomPlants)
                  Flexible(
                    // fit: FlexFit.loose,
                    child: PlantCard(
                      name: plant.name,
                      image: plant.image,
                      comments: "8",
                      price: "\$ ${plant.price}",
                      category: "Headset",
                      description: plant.description,
                    ),
                  ),
                SizedBox(width: 10)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PlantView {
  final String name;
  final double price;
  final String image;
  final String description;
  final String pk;
  PlantView({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.pk,
  });

  factory PlantView.fromJson(Map<String, dynamic> json) {
    return PlantView(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      pk: json['pk'],
      description: json['description'],
    );
  }
}

class PlantViewTop {
  final String name;
  final double price;
  final String image;
  final String description;
  final String pk;
  PlantViewTop(
      {required this.name,
      required this.price,
      required this.image,
      required this.description,
      required this.pk});

  factory PlantViewTop.fromJson(Map<String, dynamic> json) {
    return PlantViewTop(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      pk: json['pk'],
      description: json['description'],
    );
  }
}

class PlantViewBottom {
  final String name;
  final double price;
  final String image;
  final String description;
  final String pk;
  PlantViewBottom(
      {required this.name,
      required this.price,
      required this.image,
      required this.description,
      required this.pk});

  factory PlantViewBottom.fromJson(Map<String, dynamic> json) {
    return PlantViewBottom(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      pk: json['pk'],
      description: json['description'],
    );
  }
}

class Search {
  final String name;
  final double price;
  final String image;
  final String description;

  Search(
      {required this.name,
      required this.price,
      required this.image,
      required this.description});

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      description: json['description'],
    );
  }
}
