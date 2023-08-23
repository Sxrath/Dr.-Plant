// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_field, prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:dr_plant/blog.dart';
import 'package:dr_plant/disease.dart';
import 'package:dr_plant/favourites.dart';
import 'package:dr_plant/homepage.dart';
import 'package:dr_plant/profile.dart';
import 'package:dr_plant/shop.dart';
import 'package:dr_plant/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  final bool loggedIn;
  final username;
  final worker;
  const Home({Key? key, required this.loggedIn, this.username, this.worker})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

bool logIn = false;
var worker;

class _HomeState extends State<Home> {
  void setLogin() {
    setState(() {
      logIn = widget.loggedIn;
    });
    setState(() {
      worker = widget.worker;
    });
    print("++++++++++");
    print(logIn);
  }

  @override
  void initState() {
    super.initState();
    setLogin();
    // print(loggedIn);
  }

  // const Home({Key? key}) : super(key: key);

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void navigateToLogin(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      print("object");
      return Blog(
        login: widget.loggedIn,
      );
    }));
  }

  Future<String> _getCsrfToken() async {
    final storage = FlutterSecureStorage();
    return (await storage.read(key: 'csrfToken')) ?? '';
  }

  var res = "";

  late XFile _image;

  List<PlantViewTop> result = [];
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
    List<dynamic> jsonStr = jsonDecode(responseString);
    print(jsonStr[0]['name']);
    setState(() {
      res = jsonStr[0]['name'];
    });
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      print("object");
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      return DiseaseView(
        name: jsonStr[0]['name'],
        image: jsonStr[0]['image'],
        cure: jsonStr[0]['cure'],
        description: jsonStr[0]['description'],
        pk: "pk",
        type: "Disease",
      );
    }));
  }

  ImagePicker imagePicker = ImagePicker();

  Future getImage() async {
    try {
      // ImagePicker imagePicker = ImagePicker();
      var image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _image = image;
          sendImage();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              height: 70,
              decoration: BoxDecoration(
                  color: Color(0XFFC72C41),
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 98.0, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                "Please wait a few seconds",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Processing the image",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
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
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20)),
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
            duration: Duration(seconds: 20),
          ),
        );
      }

      // for sending image
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      Homepage(
          login: widget.loggedIn, username: username, worker: widget.worker),
      Blog(
        login: true,
      ),
      Shop(),
      Subsidy(
        login: false,
      ),
    ];
    return Scaffold(
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Image.asset(
      //         "assets/avatars/logo.png",
      //         width: 22,
      //       ),
      //       SizedBox(
      //         width: 8,
      //       ),
      //       Text(
      //         'Dr. Plant',
      //         style: TextStyle(
      //             color: Colors.green,
      //             // color: Colors.black87,
      //             fontFamily: 'PoppinsMedium',
      //             fontSize: 16),
      //       ),

      //       // Icon(
      //       //   Iconsax.health,
      //       //   color: Colors.black87,
      //       //   size: 18,
      //       // )
      //     ],
      //   ),
      //   actions: [
      //     Container(
      //       padding: EdgeInsets.all(7),
      //       margin: EdgeInsets.only(right: 15),
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         color: Colors.grey.withOpacity(0.1),
      //       ),
      //       child: Icon(
      //         Iconsax.notification_bing,
      //         size: 18,
      //         color: Colors.black54,
      //       ),
      //     ),
      //     GestureDetector(
      //       onTap: () {
      //         navigateToLogin(context);
      //       },
      //       child: Container(
      //         padding: EdgeInsets.all(7),
      //         margin: EdgeInsets.only(right: 15),
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Colors.grey.withOpacity(0.1),
      //         ),
      //         child: Icon(
      //           Iconsax.login,
      //           size: 18,
      //           color: Colors.black54,
      //         ),
      //       ),
      //     ),
      //     Container(
      //       padding: EdgeInsets.all(7),
      //       margin: EdgeInsets.only(right: 15),
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         color: Colors.grey.withOpacity(0.1),
      //       ),
      //       child: Icon(
      //         Iconsax.user_add,
      //         size: 18,
      //         color: Colors.black54,
      //       ),
      //     ),
      //   ],
      //   backgroundColor: Colors.white,
      //   centerTitle: false,
      //   iconTheme: IconThemeData(color: Colors.grey),
      //   // elevation: 0.2,
      //   elevation: 0,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: onTap,
        unselectedItemColor: Colors.grey.withOpacity(0.7),
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Iconsax.home),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Iconsax.document),
            ),
            label: "Blog",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Iconsax.shopping_bag),
            ),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.attach_money_rounded),
            ),
            label: "Subsidies",
          ),
        ],
        iconSize: 19,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Iconsax.camera4),
        elevation: 2,
        backgroundColor: Colors.green[500],
        // was green[500]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: pages[currentIndex],
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Material(
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top, bottom: 34),
            color: Colors.white,
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage("assets/avatars/debu.png"),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "vaisakh",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontFamily: 'PoppinsMedium'),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "vaisakh@gmail.com",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                      fontFamily: 'PoppinsRegular'),
                ),
              ],
            ),
          ),
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 4,
          children: [
            ListTile(
              leading: Icon(
                Iconsax.home,
                size: 22,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 12),
              ),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home(
                            loggedIn: false,
                          ))),
            ),
            ListTile(
                leading: Icon(
                  Iconsax.heart,
                  size: 22,
                ),
                title: Text("Favourites",
                    style:
                        TextStyle(fontFamily: 'PoppinsMedium', fontSize: 12)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FavouritesPage()));
                }),
            ListTile(
              leading: Icon(
                Iconsax.notification,
                size: 22,
              ),
              title: Text("Notifications",
                  style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 12)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Iconsax.login,
                size: 22,
              ),
              title: Text("Login",
                  style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 12)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Iconsax.user_add4,
                size: 22,
              ),
              title: Text("Signup",
                  style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 12)),
              onTap: () {},
            ),
          ],
        ),
      );
}

class PlantView {
  final String name;
  final double price;
  final String image;

  PlantView({required this.name, required this.price, required this.image});

  factory PlantView.fromJson(Map<String, dynamic> json) {
    return PlantView(
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }
}

class Result {
  final String result;

  Result({required this.result});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      result: json['result'],
    );
  }
}
