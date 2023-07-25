import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onTap;
  final double borderRadius;
  final Color? borderSideColor;
  const CustomButton({
    Key? key,
    required this.buttonText,
    this.buttonColor = primaryAppColor,
    required this.buttonTextColor,
    required this.onTap,
    this.borderRadius = 10,
    this.borderSideColor = transparentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          splashFactory: InkSplash.splashFactory,
          overlayColor: MaterialStatePropertyAll(
            whiteColor.withOpacity(0.2),
          ),
          backgroundColor: MaterialStatePropertyAll(
            buttonColor,
          ),
          fixedSize: MaterialStatePropertyAll(
            Size(screenWidth, heightValue60),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                color: borderSideColor!,
                width: 1,
              ),
            ),
          )),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: heightValue19,
            color: buttonTextColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
