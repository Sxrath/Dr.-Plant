// ignore_for_file: prefer_const_constructors

import 'package:dr_plant/products.dart';
import 'package:dr_plant/searchCard.dart';
import 'package:dr_plant/shopCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:dr_plant/variables.dart';

class SearchResult extends StatefulWidget {
  final query;
  const SearchResult({required this.query, super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<PlantView> topPlants = [];

  Future<void> getTopPlants() async {
    final response = await http.get(Uri.parse(url + 'plantsTop/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        topPlants = data.map((plant) => PlantView.fromJson(plant)).toList();
      });
      print(topPlants[1].name);
    } else {
      throw Exception('Failed to load plants');
    }
  }

  List<PlantViewBtm> bottomPlants = [];

  Future<void> getBottomPlants() async {
    final response = await http.get(Uri.parse(url + 'plantsBottom/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        bottomPlants =
            data.map((plant) => PlantViewBtm.fromJson(plant)).toList();
      });
      print(bottomPlants[1].name);
    } else {
      throw Exception('Failed to load plants');
    }
  }

  List<PlantView> plants = [];
  var i = 0;
  Future<void> getResult() async {
    try {
      final response = await http.post(
        Uri.parse(url + 'search/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'query': widget.query}),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          plants = data.map((plant) => PlantView.fromJson(plant)).toList();
        });
        // print(plants[1].name);
      } else {
        throw Exception('Failed to load plants');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search results",
          style: TextStyle(fontFamily: "HelveticaBold", color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Results  🪴",
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
            for (var plant in plants)
              SearchCard(
                name: plant.name,
                image: plant.image,
                price: "\$ ${plant.price}",
                description: plant.description,
                // pk: plant.pk,
              ),
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
  PlantView(
      {required this.name,
      required this.price,
      required this.image,
      required this.description});

  factory PlantView.fromJson(Map<String, dynamic> json) {
    return PlantView(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      description: json['description'],
    );
  }
}

class PlantViewBtm {
  final String name;
  final double price;
  final String image;
  final String description;

  PlantViewBtm(
      {required this.name,
      required this.price,
      required this.image,
      required this.description});

  factory PlantViewBtm.fromJson(Map<String, dynamic> json) {
    return PlantViewBtm(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      description: json['description'],
    );
  }
}
