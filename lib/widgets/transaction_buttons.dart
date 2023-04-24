// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';

class TransactionButton extends StatelessWidget {
  final String buttonText;
  Color buttonColor;
  Color buttonTextColor;
  final VoidCallback onTap;
  final Icon buttonIcon;
  double buttonHeight;
  TransactionButton({
    Key? key,
    this.buttonText = '',
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onTap,
    required this.buttonIcon,
    this.buttonHeight = 50,
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
            Size(double.infinity, buttonHeight),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttonIcon,
          const SizedBox(
            width: 7,
          ),
          Text(
            buttonText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: buttonTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
