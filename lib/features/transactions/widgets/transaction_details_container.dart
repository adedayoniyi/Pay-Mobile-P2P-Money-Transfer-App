import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';

import 'package:pay_mobile_app/core/utils/global_constants.dart';

class TransactionDetailsContainer extends StatelessWidget {
  final String label;
  final String content;
  final Color amountColor;
  final bool isRow;
  final bool isAmount;
  const TransactionDetailsContainer({
    Key? key,
    required this.label,
    required this.content,
    this.amountColor = defaultAppColor,
    this.isRow = false,
    this.isAmount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: heightValue15),
      child: Container(
        width: screenWidth,
        height: heightValue100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(heightValue10),
          color: greyScale850,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: value10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: heightValue15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              isRow
                  ? Row(
                      children: [
                        Image.asset(
                          "assets/images/dialog_success_image.png",
                          height: heightValue25,
                        ),
                        SizedBox(
                          width: value5,
                        ),
                        Text(
                          content,
                          style: TextStyle(
                            fontSize: heightValue24,
                            color: primaryAppColor,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      content,
                      style: TextStyle(
                        fontSize: heightValue24,
                        color: primaryAppColor,
                        fontWeight:
                            isAmount ? FontWeight.bold : FontWeight.normal,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
