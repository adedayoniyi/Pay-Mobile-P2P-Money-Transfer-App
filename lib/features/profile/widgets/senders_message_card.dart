import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';

class SendersMessageCard extends StatelessWidget {
  final String message;
  final String dateTime;
  final String user;

  const SendersMessageCard({
    Key? key,
    required this.message,
    required this.dateTime,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - value48,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            right: value20,
            top: heightValue15,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFb8c2b7),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: value10, vertical: heightValue10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user,
                    style: TextStyle(
                      color: tertiaryAppColor,
                      fontSize: heightValue13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  HeightSpace(heightValue10),
                  Text(
                    message,
                    style: TextStyle(
                      color: secondaryAppColor,
                      fontSize: heightValue18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  HeightSpace(heightValue5),
                  Text(
                    dateTime,
                    style: TextStyle(
                      color: secondaryAppColor,
                      fontSize: heightValue13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
