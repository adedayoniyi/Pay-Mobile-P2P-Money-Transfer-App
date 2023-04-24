import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/color_constants.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/textstyle_constants.dart';
import 'package:money_transfer_app/features/auth/screens/login_screen.dart';
import 'package:money_transfer_app/features/auth/screens/signup_screen.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String route = "/onboarding-screen";
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: value20),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: value20),
                        child: Container(
                          height: heightValue275,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(value45),
                            color: greyScale300,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: value10),
                        child: Container(
                          height: heightValue260,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(value40),
                              color: greyScale400),
                        ),
                      ),
                      Container(
                        height: heightValue240,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(value30),
                          color: defaultAppColor,
                        ),
                        child: Image.asset(
                          "assets/images/onBoardingImage.png",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: heightValue100),
                        child: const Text("Send & request payments"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightValue50,
                  ),
                  Text(
                    "Send & request payments",
                    style: heading6GreyScale900,
                  ),
                  SizedBox(
                    height: heightValue10,
                  ),
                  Text(
                    "Send or recieve any payments from your accounts with ease and comfort.",
                    textAlign: TextAlign.center,
                    style: textSmallNormalGreyScale600,
                  )
                ],
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
                      SizedBox(
                        height: heightValue10,
                      ),
                      Text(
                        "The Best Way to Transfer Money Safely",
                        style: textSmallNormalGreyScale600,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: heightValue20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                          buttonText: "Create Account",
                          buttonColor: defaultAppColor,
                          buttonTextColor: whiteColor,
                          onTap: () {
                            Navigator.pushNamed(context, SignUpScreen.route);
                          }),
                      SizedBox(
                        height: heightValue10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.route);
                        },
                        child: Text(
                          "Already have an account?",
                          style: textRegularMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
