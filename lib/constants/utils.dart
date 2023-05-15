import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/widgets/alert_message.dart';

void showAlertMessage(
    {required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onTap}) {
  showDialog(
    context: context,
    builder: (context) =>
        AlertMessage(title: title, message: message, onTap: onTap),
  );
}

void showErrorMessage(
    {required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onTap}) {
  showDialog(
    context: context,
    builder: (context) => AlertMessage(
      title: title,
      message: message,
      onTap: onTap,
      alertImage: "assets/images/error_image.png",
    ),
  );
}

void showTimeOutError(
    {required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onTap}) {
  showDialog(
    context: context,
    builder: (context) => AlertMessage(
      title: title,
      message: message,
      onTap: onTap,
      alertImage: "assets/icons/info-circle.png",
    ),
  );
}

void showNoInternetError({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onTap,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertMessage(
      title: title,
      message: message,
      onTap: onTap,
      alertImage: "assets/images/no-internet.png",
      buttonColor: Colors.red,
    ),
  );
}

void showDialogLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          content: Center(
            child: Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(color: whiteColor),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void showSnackBar(BuildContext context, String text) {}

void showMaterialBanner({
  required BuildContext context,
  required String image,
  required String description,
  required String amount,
  required Color amountColor,
  String prefix = "",
  String shortDesc = '',
  bool isFromTo = true,
}) {
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      shadowColor: Colors.transparent,
      elevation: 10,
      content: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  image,
                  height: heightValue100,
                ),
                Column(
                  children: [
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: heightValue23,
                        color: defaultAppColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          prefix,
                          style: TextStyle(
                            fontSize: heightValue18,
                          ),
                        ),
                        Text(
                          shortDesc,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: heightValue18,
                            fontWeight:
                                isFromTo ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "$amount",
                  style: TextStyle(
                    color: amountColor,
                    fontSize: heightValue24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.7),
      actions: [Text("")],
    ),
  );
}
