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
      height: heightValue80,
      width: heightValue80,
      margin: EdgeInsets.only(right: value10),
      decoration: BoxDecoration(
        color: greyScale200,
        shape: BoxShape.circle,
        border: Border.all(
          color: index == selectedIndex ? defaultAppColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: pin.length > index
          ? Container(
              width: value15,
              height: value15,
              decoration: const BoxDecoration(
                color: defaultAppColor,
                shape: BoxShape.circle,
              ),
            )
          : const SizedBox(),
    );
  }
}
