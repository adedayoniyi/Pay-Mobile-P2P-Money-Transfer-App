import 'package:flutter/material.dart';

import 'package:money_transfer_app/constants/global_constants.dart';

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
      child: Stack(
        children: [
          Container(
            height: heightValue80,
            width: screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(heightValue20),
              color: whiteColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: value20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: heightValue35,
                    width: heightValue35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(value35),
                      color: scaffoldBackgroundColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        transactionTypeImage,
                        height: heightValue20,
                        color: amountColorBasedOnTransactionType,
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
                            style: TextStyle(
                              fontSize: heightValue20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            trnxSummary,
                            style: TextStyle(
                              fontSize: heightValue17,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "₦${amountFormatter.format(amount)}",
                        style: TextStyle(
                          color: amountColorBasedOnTransactionType,
                          fontSize: heightValue20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: value10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: heightValue20,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                  heightValue20,
                ),
                topLeft: Radius.circular(
                  heightValue25,
                ),
              ),
              child: Container(
                height: heightValue25,
                width: heightValue25,
                decoration: const BoxDecoration(
                  color: Color(0xFFDFAD2C),
                ),
              ),
            ),
          ),
          // Positioned(
          //   left: 0,
          //   top: 0,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.only(
          //       bottomRight: Radius.circular(
          //         heightValue25,
          //       ),
          //       topLeft: Radius.circular(
          //         heightValue20,
          //       ),
          //     ),
          //     child: Container(
          //       height: heightValue25,
          //       width: heightValue25,
          //       decoration: const BoxDecoration(
          //         color: Color(0xFF5337A5),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
