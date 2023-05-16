import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: heightValue43,
        width: heightValue43,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
