import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/utils.dart';

class ClipPathTopRightForBalanceCard extends StatelessWidget {
  const ClipPathTopRightForBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
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
            (heightValue180 * 0.5567901611328125).toDouble(),
          ),
          painter: CurvedContainerPath(isFirst: true),
        ),
      ),
    );
  }
}
