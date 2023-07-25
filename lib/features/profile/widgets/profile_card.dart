import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';

import 'package:pay_mobile_app/core/utils/global_constants.dart';

class ProfileCard extends StatelessWidget {
  final String iconImage;
  final String profileOperation;
  final String profileOperationDescription;
  final VoidCallback onPressed;
  const ProfileCard({
    Key? key,
    required this.iconImage,
    required this.profileOperation,
    required this.profileOperationDescription,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: heightValue80,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(heightValue20),
          color: greyScale850,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: value20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: heightValue55,
                    width: heightValue55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(value10),
                      color: secondaryAppColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        iconImage,
                        height: heightValue25,
                        color: primaryAppColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: value20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileOperation,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: heightValue20,
                            ),
                          ),
                          Text(
                            profileOperationDescription,
                            style: TextStyle(
                              fontSize: heightValue15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}
