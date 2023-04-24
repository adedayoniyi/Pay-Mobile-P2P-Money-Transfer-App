import 'package:flutter/material.dart';

import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/textstyle_constants.dart';

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
        height: heightValue100,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(value20),
          color: whiteColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: value20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: value55,
                width: value55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(value10),
                  color: scaffoldBackgroundColor,
                ),
                child: Center(
                  child: Image.asset(
                    iconImage,
                    height: value25,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: value20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileOperation,
                        style: textMediumBoldGreyScale900,
                      ),
                      Text(
                        profileOperationDescription,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}
