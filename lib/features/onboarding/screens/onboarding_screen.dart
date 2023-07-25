import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/features/auth/screens/login_screen.dart';
import 'package:pay_mobile_app/features/auth/screens/signup_screen.dart';
import 'package:pay_mobile_app/features/onboarding/screens/widgets/glassmorphic_card.dart';
import 'package:pay_mobile_app/widgets/custom_button.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String route = "/onboarding-screen";
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: value10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: heightValue30),
                  child: Column(
                    children: [
                      Image.asset(
                        mainLogo,
                        height: heightValue50,
                      ),
                      SizedBox(
                        height: heightValue10,
                      ),
                      Text(
                        "The Best Way to Transfer Money Safely",
                        style: TextStyle(
                          fontSize: heightValue15,
                          color: greyScale500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 150,
                right: 0,
                child: Image.asset(
                  gradientCircle,
                  height: heightValue200,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GlassmorphicCard(height: heightValue230, width: 355),
                  HeightSpace(heightValue35),
                  Text(
                    "Send & request payments",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: heightValue30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: heightValue20,
                  ),
                  Text(
                    "Send or recieve any payments from your accounts with ease and comfort.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: heightValue18,
                      color: greyScale500,
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: heightValue20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                          borderRadius: heightValue45,
                          buttonText: "Create Account",
                          buttonColor: primaryAppColor,
                          buttonTextColor: scaffoldBackgroundColor,
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: heightValue18,
                          ),
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
