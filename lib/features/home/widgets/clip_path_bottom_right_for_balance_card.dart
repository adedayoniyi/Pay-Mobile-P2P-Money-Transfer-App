import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/utils.dart';

class ClipPathBottomRightForBalanceCard extends StatelessWidget {
  const ClipPathBottomRightForBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            heightValue30,
          ),
        ),
        child: RotatedBox(
          quarterTurns: 2,
          child: CustomPaint(
            size: Size(
              heightValue180,
              (heightValue180 * 0.5567901611328125).toDouble(),
            ),
            painter: CurvedContainerPath(isFirst: false),
          ),
        ),
      ),
    );
  }
}
