// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';

class AlertMessage extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onTap;
  String alertImage;
  Color buttonColor;
  AlertMessage({
    Key? key,
    required this.title,
    required this.message,
    required this.onTap,
    this.alertImage = "assets/images/dialog_success_image.png",
    this.buttonColor = defaultAppColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        icon: Image.asset(
          alertImage,
          height: heightValue100,
          width: heightValue100,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: value18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: heightValue15,
            color: Colors.grey[600],
          ),
        ),
        actions: <Widget>[
          CustomButton(
            buttonText: "Okay",
            onTap: onTap,
            buttonColor: buttonColor,
            buttonTextColor: whiteColor,
          )
        ],
      ),
    );
  }
}
