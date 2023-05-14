import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';

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
    return TextButton(
      onPressed: onTap,
      child: Text(
        numberText,
        style: TextStyle(
          fontSize: heightValue45,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
