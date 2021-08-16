import 'package:flutter/material.dart';
import 'package:uji/core/utils/colors.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: RefillStationColors.background(),
        alignment: Alignment.center,
        child: Image(
          image: AssetImage("images/refill_station_logo.png"),
        ),
      ),
    );
  }
}
