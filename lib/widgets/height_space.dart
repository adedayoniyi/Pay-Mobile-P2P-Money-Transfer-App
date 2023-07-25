import 'package:flutter/material.dart';

class HeightSpace extends StatelessWidget {
  final double height;
  const HeightSpace(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
