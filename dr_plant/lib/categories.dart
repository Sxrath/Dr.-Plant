import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.all(0),
          width: 150,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.0),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/avatars/plant3.jpg",
                      width: 25,
                      height: 25,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "Bonsai ",
                      style: TextStyle(
                          fontFamily: "HelveticaBold",
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                  ),
                  Text(
                    "14 plants",
                    style: TextStyle(
                        fontFamily: "HelveticaMedium",
                        fontSize: 12,
                        color: Colors.black87.withOpacity(0.5)),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.all(0),
          width: 140,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.0),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/avatars/plant8.jpg",
                      width: 25,
                      height: 25,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "Potted",
                      style: TextStyle(
                          fontFamily: "HelveticaBold",
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                  ),
                  Text(
                    "27 plants",
                    style: TextStyle(
                        fontFamily: "HelveticaMedium",
                        fontSize: 12,
                        color: Colors.black87.withOpacity(0.5)),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.all(0),
          width: 140,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.0),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/avatars/plant10.jpg",
                      width: 25,
                      height: 25,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "Outdoor",
                      style: TextStyle(
                          fontFamily: "HelveticaBold",
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                  ),
                  Text(
                    "78 plants",
                    style: TextStyle(
                        fontFamily: "HelveticaMedium",
                        fontSize: 12,
                        color: Colors.black87.withOpacity(0.5)),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.all(0),
          width: 140,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.0),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/avatars/plant2.jpg",
                      width: 25,
                      height: 25,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "All plants",
                      style: TextStyle(
                          fontFamily: "HelveticaBold",
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                  ),
                  Text(
                    "150 plants",
                    style: TextStyle(
                        fontFamily: "HelveticaMedium",
                        fontSize: 12,
                        color: Colors.black87.withOpacity(0.5)),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
