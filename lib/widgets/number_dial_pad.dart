import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/widgets/border_painter.dart';

class NumberDialPad extends StatelessWidget {
  final VoidCallback onTap;
  final String numberText;
  const NumberDialPad({
    Key? key,
    required this.onTap,
    required this.numberText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          SizedBox(
            height: heightValue75,
            width: heightValue75,
            child: CustomPaint(
              painter: BorderPainter(borderRadius: heightValue75),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 10,
            bottom: 0,
            child: Text(
              numberText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryAppColor,
                fontSize: heightValue40,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
