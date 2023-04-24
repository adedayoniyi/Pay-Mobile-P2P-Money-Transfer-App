import 'package:flutter/material.dart';

import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/textstyle_constants.dart';

class TransactionsCard extends StatelessWidget {
  final String transactionTypeImage;
  final String transactionType;
  final String trnxSummary;
  final int amount;
  final Color amountColorBasedOnTransactionType;
  const TransactionsCard({
    Key? key,
    required this.transactionTypeImage,
    required this.transactionType,
    required this.trnxSummary,
    required this.amount,
    required this.amountColorBasedOnTransactionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: heightValue80,
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
                height: value35,
                width: value35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(value35),
                  color: scaffoldBackgroundColor,
                ),
                child: Center(
                  child: Image.asset(
                    transactionTypeImage,
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
                        transactionType,
                        style: textMediumBoldGreyScale900,
                      ),
                      Text(
                        trnxSummary,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
              Text(
                "₦$amount",
                style: TextStyle(
                  color: amountColorBasedOnTransactionType,
                  fontSize: value18,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
