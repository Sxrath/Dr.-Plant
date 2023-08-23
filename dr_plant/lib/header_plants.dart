// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

class Plant extends StatefulWidget {
  final name;
  final image;
  final price;

  const Plant({
    Key? key,
    this.name,
    this.price,
    this.image,
  }) : super(key: key);

  @override
  State<Plant> createState() => _PlantState();
}

class _PlantState extends State<Plant> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Container(
            // width: 150,
            width: 150,
            height: 260,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image(
                    image: AssetImage(widget.image),
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 0),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "PoppinsRegular",
                        color: Colors.black.withOpacity(0.7)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 0),
                  child: Text(
                    widget.price,
                    style: TextStyle(
                        height: 1.5,
                        fontFamily: "PoppinsBold",
                        fontSize: 12,
                        color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Iconsax.heart,
                  size: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
