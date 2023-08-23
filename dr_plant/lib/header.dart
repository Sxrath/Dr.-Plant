import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.94,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(13),
        ),
        height: 180,
        child: Stack(
          children: [
            Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.03)),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "House plants \nseeds",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "PoppinsMedium",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Discover plants and more",
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "PoppinsMedium",
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            backgroundColor: Colors.black87,
                          ),
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Text(
                                "shop now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 12,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Image.asset("assets/avatars/plant.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
