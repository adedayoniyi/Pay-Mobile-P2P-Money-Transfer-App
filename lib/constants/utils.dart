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

void showNoInternetError(
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
      alertImage: "assets/images/no-internet.png",
      buttonColor: Colors.red,
    ),
  );
}

void showDialogLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
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
  );
}

void showSnackBar(BuildContext context, String text) {}

void showMaterialBanner({
  required BuildContext context,
  required String image,
  required String description,
  required String amount,
  required Color amountColor,
}) {
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      shadowColor: Colors.transparent,

      elevation: 10,

      content: Column(
        children: [
          Text(description),
          Text(
            amount,
            style: TextStyle(
              color: amountColor,
              fontSize: value24,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      leadingPadding: EdgeInsets.zero,
      leading: Image.asset(
        image,
        height: value80,
      ),
      backgroundColor: whiteColor,
      //padding: const EdgeInsets.all(16),
      contentTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      actions: [TextButton(onPressed: () {}, child: Text(""))],
    ),
  );
}
