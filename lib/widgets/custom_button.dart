// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  Color buttonColor;
  Color buttonTextColor;
  final VoidCallback onTap;
  CustomButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll(
            whiteColor.withOpacity(0.2),
          ),
          backgroundColor: MaterialStatePropertyAll(
            buttonColor,
          ),
          fixedSize: MaterialStatePropertyAll(
            Size(screenWidth, heightValue50),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: heightValue17,
            color: buttonTextColor,
          ),
        ),
      ),
    );
  }
}
