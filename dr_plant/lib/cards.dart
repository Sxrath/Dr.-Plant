import 'package:dr_plant/productView.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PlantCard extends StatefulWidget {
  final name;
  final category;
  final price;
  final comments;
  final image;
  final description;
  const PlantCard({
    this.name,
    this.category,
    this.price,
    this.comments,
    this.image,
    this.description,
    Key? key,
  }) : super(key: key);

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10, right: 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          // width: 200,
          // height: 320,
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
                  SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // Icon(
                        //   Icons.shopping_bag,
                        //   color: Colors.white,
                        //   size: 18,
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return ProductView(
                                name: widget.name,
                                image: widget.image,
                                price: widget.price,
                                description: widget.description,
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
                        // Icon(
                        //   Icons.favorite,
                        //   color: Colors.white,
                        //   size: 18,
                        // ),
                        // Icon(
                        //   Icons.share,
                        //   color: Colors.white,
                        //   size: 18,
                        // ),
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
      ),
    );
  }
}
