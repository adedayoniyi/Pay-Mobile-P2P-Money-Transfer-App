import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/color_constants.dart';
import 'package:money_transfer_app/constants/global_constants.dart';

class PinInputField extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final String pin;

  const PinInputField({
    Key? key,
    required this.selectedIndex,
    required this.index,
    required this.pin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: value60,
      width: value60,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: greyScale100,
        shape: BoxShape.circle,
        border: Border.all(
            color:
                index == selectedIndex ? defaultAppColor : Colors.transparent,
            width: 2),
      ),
      child: pin.length > index
          ? Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.black.withBlue(40),
                shape: BoxShape.circle,
              ),
            )
          : const SizedBox(),
    );
  }
}
