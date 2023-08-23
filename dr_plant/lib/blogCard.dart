// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:depression/banner.dart';
import 'package:dr_plant/blogView.dart';
// import 'package:depression/productView.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatefulWidget {
  final name;
  final image;
  final description;
  final pk;
  final date;
  const BlogCard({
    required this.name,
    required this.image,
    required this.description,
    required this.pk,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 25),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/avatars/profile.jpg"),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Admin",
                              style: TextStyle(
                                  fontFamily: "HelveticaBold",
                                  color: Colors.black,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.date,
                              style: TextStyle(
                                  fontFamily: "HelveticaMedium",
                                  color: Color.fromARGB(255, 127, 127, 127),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    ),
                    Icon(
                      Icons.linear_scale_sharp,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              // SizedBox(height: 15),
              Image.network(
                widget.image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                child: Text(
                  widget.name,
                  style: TextStyle(
                      fontFamily: "HelveticaBold",
                      color: Colors.black,
                      fontSize: 19),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "HelveticaMedium",
                      color: Color.fromARGB(255, 114, 114, 114),
                      fontSize: 15,
                      height: 1.6),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    print("object");
                    return BlogView(
                      name: widget.name,
                      image: widget.image,
                      comments: "product.comments",
                      price: "product.price",
                      category: "product.category",
                      description: widget.description,
                      pk: widget.pk,
                    );
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color.fromARGB(255, 233, 233, 233)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Read More",
                        style: TextStyle(
                            color: Color.fromARGB(255, 24, 24, 24),
                            fontFamily: "HelveticaBold",
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
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
