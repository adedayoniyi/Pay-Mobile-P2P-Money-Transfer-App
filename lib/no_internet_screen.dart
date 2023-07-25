import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/widgets/custom_button.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onTap;
  const NoInternetScreen({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: value30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      noInternetImage,
                      height: heightValue150,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: heightValue20,
                    ),
                    const Text("Please connect to the internet"),
                    SizedBox(
                      height: heightValue50,
                    ),
                    CustomButton(
                        buttonText: "Try Again",
                        buttonColor: primaryAppColor,
                        buttonTextColor: whiteColor,
                        onTap: () {
                          onTap();
                        })
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: heightValue30),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/full_logo.png",
                      height: value100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
