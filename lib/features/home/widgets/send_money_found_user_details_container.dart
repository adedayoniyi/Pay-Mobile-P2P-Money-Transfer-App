import 'package:flutter/material.dart';

import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/widgets/border_painter.dart';

class SendMoneyFoundUserDetailsContainer extends StatelessWidget {
  final String circleAvatarText;
  final String userFullName;
  final String userName;
  const SendMoneyFoundUserDetailsContainer({
    Key? key,
    required this.circleAvatarText,
    required this.userFullName,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: screenWidth,
            height: heightValue80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(heightValue20),
            ),
            child: CustomPaint(
              painter: BorderPainter(borderRadius: heightValue20),
            )),
        Positioned(
          top: 0,
          bottom: 0,
          child: Row(
            children: [
              SizedBox(
                width: value20,
              ),
              CircleAvatar(
                radius: heightValue25,
                child: Center(
                  child: Text(
                    circleAvatarText,
                    style: TextStyle(
                      fontSize: heightValue23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: value25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userFullName,
                    style: TextStyle(
                      fontSize: heightValue23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: heightValue18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
