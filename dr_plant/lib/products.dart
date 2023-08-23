// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:dr_plant/productView.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Product extends StatefulWidget {
  final name;

  final price;
  final description;
  final image;
  final type;
  final pk;
  const Product({
    this.name,
    this.price,
    this.description,
    this.image,
    this.type,
    this.pk,
    Key? key,
  }) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
      child: Container(
        width: 200,
        height: 280,
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(
                      widget.image,
                      width: 170,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        fontFamily: "HelveticaBold",
                        fontSize: 17,
                        color: Colors.black87),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    widget.price,
                    style: TextStyle(
                        fontFamily: "HelveticaBold",
                        fontSize: 15,
                        color: Color(0xff6ea820)),
                  ),
                ),
                SizedBox(height: 17),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return ProductView(
                              name: widget.name,
                              image: widget.image,
                              price: widget.price,
                              description: widget.description,
                              pk: widget.pk,
                              type: widget.type,
                            );
                          }));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 18),
                            Text(
                              "View product",
                              style: TextStyle(
                                  fontFamily: "HelveticaBold",
                                  color: Colors.white,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Positioned(
            //   top: 5,
            //   right: 10,
            //   child: Container(
            //     margin: EdgeInsets.only(left: 20, top: 20),
            //     width: 25,
            //     height: 25,
            //     // height: 20,
            //     child: Center(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         // ignore: prefer_const_literals_to_create_immutables
            //         children: [
            //           Icon(
            //             Icons.favorite,
            //             color: Colors.white,
            //             size: 13,
            //           ),
            //           // SizedBox(width: 5),
            //         ],
            //       ),
            //     ),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(100),
            //       color: Colors.black.withOpacity(0.5),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
