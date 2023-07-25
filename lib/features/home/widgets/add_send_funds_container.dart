import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';

class AddSendFundsContainers extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onTap;
  const AddSendFundsContainers({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: heightValue50,
        width: heightValue120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(heightValue20),
          color: primaryAppColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: heightValue35,
              color: secondaryAppColor,
            ),
            SizedBox(
              width: value5,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: heightValue17,
                color: secondaryAppColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
