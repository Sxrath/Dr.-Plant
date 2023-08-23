import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

class BannerPlant extends StatefulWidget {
  const BannerPlant({Key? key}) : super(key: key);

  @override
  State<BannerPlant> createState() => _BannerPlantState();
}

class _BannerPlantState extends State<BannerPlant> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      child: Container(
        child: Column(
          children: [Image.asset("assets/avatars/debu.png")],
        ),
      ),
    );
  }
}
