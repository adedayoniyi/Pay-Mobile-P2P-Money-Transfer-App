import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/color_constants.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/utils.dart';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: isTablet ? screenWidth / 1.5 : screenWidth,
                      height: isTablet ? heightValue280 : heightValue275,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: value20),
                            child: Container(
                              height: heightValue275,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(value45),
                                color: const Color(0xFF2248A9),
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
                                  color: const Color(0xFFEBB850)),
                            ),
                          ),
                          Stack(
                            children: [
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
                              Align(
                                alignment: Alignment.topRight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                      heightValue30,
                                    ),
                                  ),
                                  child: CustomPaint(
                                    size: Size(
                                      heightValue180,
                                      (heightValue180 * 0.5567901611328125)
                                          .toDouble(),
                                    ),
                                    painter: CurvedContainerPath(isFirst: true),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: heightValue100),
                            child: const Text("Send & request payments"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightValue50,
                  ),
                  Text(
                    "Send & request payments",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: heightValue30,
                    ),
                  ),
                  SizedBox(
                    height: heightValue10,
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
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: heightValue30),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/full_logo.png",
                        height: heightValue100,
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
