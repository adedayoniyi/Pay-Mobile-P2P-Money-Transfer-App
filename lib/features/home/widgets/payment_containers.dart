import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/widgets/border_painter.dart';

class PaymentContainers extends StatelessWidget {
  final String icon;
  final Color color;
  final String text;
  const PaymentContainers({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          // Positioned(
          //   right: 20,
          //   bottom: 40,
          //   child: Image.asset(
          //     gradientCircle,
          //     height: heightValue50,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(right: value10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(heightValue20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 5),
                child: Container(
                  height: heightValue140,
                  width: heightValue120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(heightValue15),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.0,
                    ),
                  ),
                  child: CustomPaint(
                    painter: BorderPainter(
                      firstColor: primaryAppColor,
                      secondColor: tertiaryAppColor,
                      borderRadius: heightValue20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Image.asset(
              icon,
              color: whiteColor,
              height: heightValue33,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: heightValue17,
              ),
            ),
          )
        ],
      ),
    );
  }
}
