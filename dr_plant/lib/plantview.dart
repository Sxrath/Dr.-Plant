import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductCard extends StatefulWidget {
  final name;
  final category;
  final price;
  final comments;
  final image;

  const ProductCard({
    this.name,
    this.category,
    this.price,
    this.comments,
    this.image,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, bottom: 10, top: 10),
      child: FractionallySizedBox(
        widthFactor: 0.95,
        child: Container(
          // width: 240,
          height: 330,
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
                    child: Image.asset(
                      widget.image,
                      width: 150,
                      height: 150,
                      // fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        width: 55,
                        height: 25,
                        // height: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Text(
                              "New",
                              style: TextStyle(
                                  fontFamily: "HelveticaBold",
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFee5750),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20),
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              fontFamily: "HelveticaBold",
                              fontSize: 17,
                              color: Colors.black87),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: Text(
                          widget.category,
                          style: TextStyle(
                              fontFamily: "Helvetica",
                              fontSize: 15,
                              color: Colors.black87.withOpacity(0.5)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20),
                        child: Text(
                          widget.price,
                          style: TextStyle(
                              fontFamily: "HelveticaBold",
                              fontSize: 19,
                              color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 25,
                right: 20,
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                      color: Color(0xFFf77231),
                      borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Text(
                        "Buy now",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "HelveticaBold",
                            fontSize: 13),
                      ))),
                ),
              ),
              Positioned(
                top: -10,
                right: 10,
                child: Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  width: 55,
                  height: 25,
                  // height: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.star5,
                            color: Color(0xFFea7120),
                            size: 15,
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.comments,
                            style: TextStyle(
                                fontFamily: "HelveticaBold",
                                fontSize: 12,
                                color: Color(0xFFbd9770)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFfcf4f1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
