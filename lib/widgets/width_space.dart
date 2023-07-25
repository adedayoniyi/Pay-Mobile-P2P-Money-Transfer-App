import 'package:flutter/material.dart';

class WidthSpace extends StatelessWidget {
  final double width;
  const WidthSpace(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
