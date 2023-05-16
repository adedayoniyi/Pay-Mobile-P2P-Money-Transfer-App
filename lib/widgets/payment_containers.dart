import 'package:flutter/material.dart';

import 'package:money_transfer_app/constants/global_constants.dart';

class PaymentContainers extends StatelessWidget {
  final String icon;
  final Color color;
  final VoidCallback onTap;
  const PaymentContainers({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: heightValue60,
        width: heightValue60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(heightValue15),
          color: color,
        ),
        child: Center(
          child: Image.asset(
            icon,
            color: whiteColor,
            height: heightValue33,
          ),
        ),
      ),
    );
  }
}
