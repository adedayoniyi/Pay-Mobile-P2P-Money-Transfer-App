import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/color_constants.dart';

import 'package:money_transfer_app/constants/global_constants.dart';

class TransactionDetailsContainer extends StatelessWidget {
  final String label;
  final String content;
  Color amountColor;
  bool isRow;
  bool isAmount;
  TransactionDetailsContainer({
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
          color: greyScale100,
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
                            color: amountColor,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      content,
                      style: TextStyle(
                        fontSize: heightValue24,
                        color: amountColor,
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
