import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';

class BorderPainter extends CustomPainter {
  final Color firstColor;
  final Color secondColor;
  final double borderRadius;
  BorderPainter({
    this.firstColor = primaryAppColor,
    this.secondColor = tertiaryAppColor,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        firstColor,
        secondColor.withOpacity(0.4),
      ],
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect,
        Radius.circular(borderRadius),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
