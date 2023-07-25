import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/widgets/border_painter.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';

class CommingSoonScreen extends StatelessWidget {
  static const String route = "/comming-soon-screen";
  const CommingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: value30),
        child: Column(
          children: [
            HeightSpace(heightValue30),
            Image.asset(
              mainLogo,
              height: heightValue130,
            ),
            HeightSpace(heightValue20),
            Text(
              "Comming Soon",
              style: TextStyle(
                fontSize: value25,
                fontWeight: FontWeight.bold,
              ),
            ),
            HeightSpace(heightValue20),
            Stack(
              children: [
                Positioned(
                  top: 70,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Text(
                    "Coming Soon",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: heightValue35,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: heightValue200,
                  width: screenWidth,
                  child: CustomPaint(
                    painter: BorderPainter(borderRadius: heightValue20),
                  ),
                ),
              ],
            ),
            HeightSpace(heightValue40),
            Text(
              "This feature is Comming Soon. Stay tuned",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: value25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
