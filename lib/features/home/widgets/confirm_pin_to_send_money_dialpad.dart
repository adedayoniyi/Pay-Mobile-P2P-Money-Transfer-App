// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';
import 'package:pay_mobile_app/widgets/width_space.dart';
import 'package:provider/provider.dart';

import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/features/home/services/home_service.dart';
import 'package:pay_mobile_app/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_app/widgets/custom_button.dart';
import 'package:pay_mobile_app/widgets/number_dial_pad.dart';
import 'package:pay_mobile_app/widgets/pin_input_field.dart';

class ConfirmPinToSendMoneyDialPad extends StatefulWidget {
  final VoidCallback onSuccess;
  const ConfirmPinToSendMoneyDialPad({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<ConfirmPinToSendMoneyDialPad> createState() =>
      _ConfirmPinToSendMoneyDialPadState();
}

class _ConfirmPinToSendMoneyDialPadState
    extends State<ConfirmPinToSendMoneyDialPad> {
  final HomeService homeService = HomeService();
  var selectedindex = 0;
  String pin = '';

  addDigit(int digit) {
    if (pin.length > 3) {
      return;
    }
    setState(() {
      pin = pin + digit.toString();
      print('pin is $pin');
      selectedindex = pin.length;
      if (pin.length > 3) {
        confirmTransactionUsingPin();
      }
    });
  }

  backspace() {
    if (pin.isEmpty) {
      return;
    }
    setState(() {
      pin = pin.substring(0, pin.length - 1);
      selectedindex = pin.length;
    });
  }

  void confirmTransactionUsingPin() {
    final username =
        Provider.of<UserProvider>(context, listen: false).user.username;
    homeService.confirmPinBeforeTransfer(
      context: context,
      pin: pin,
      username: username,
      onSuccess: () {
        Navigator.pop(context);
        widget.onSuccess();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: value20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: heightValue60,
                ),
                Image.asset(
                  logo,
                  height: heightValue65,
                ),
                HeightSpace(heightValue10),
                Row(
                  children: [
                    Text(
                      "Hey,",
                      style: TextStyle(
                        fontSize: heightValue35,
                      ),
                    ),
                    WidthSpace(value10),
                    Icon(
                      Icons.waving_hand,
                      color: Colors.amber,
                      size: heightValue35,
                    )
                  ],
                ),
                HeightSpace(heightValue10),
                Text(
                  user.fullname,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: heightValue35,
                  ),
                ),
                HeightSpace(heightValue20),
                Text(
                  "Enter your 4 digit pin to complete",
                  style: TextStyle(fontSize: heightValue22),
                ),
                SizedBox(
                  height: heightValue30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PinInputField(
                      index: 0,
                      selectedIndex: selectedindex,
                      pin: pin,
                    ),
                    PinInputField(
                        index: 1, selectedIndex: selectedindex, pin: pin),
                    PinInputField(
                        index: 2, selectedIndex: selectedindex, pin: pin),
                    PinInputField(
                        index: 3, selectedIndex: selectedindex, pin: pin),
                  ],
                ),
                HeightSpace(heightValue30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberDialPad(onTap: () => addDigit(1), numberText: '1'),
                    NumberDialPad(onTap: () => addDigit(2), numberText: '2'),
                    NumberDialPad(onTap: () => addDigit(3), numberText: '3'),
                  ],
                ),
                HeightSpace(heightValue20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberDialPad(onTap: () => addDigit(4), numberText: '4'),
                    NumberDialPad(onTap: () => addDigit(5), numberText: '5'),
                    NumberDialPad(onTap: () => addDigit(6), numberText: '6'),
                  ],
                ),
                HeightSpace(heightValue20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberDialPad(onTap: () => addDigit(7), numberText: '7'),
                    NumberDialPad(onTap: () => addDigit(8), numberText: '8'),
                    NumberDialPad(onTap: () => addDigit(9), numberText: '9'),
                  ],
                ),
                HeightSpace(heightValue20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(
                          Size(heightValue75, heightValue75),
                        ),
                      ),
                      onPressed: () {
                        backspace();
                      },
                      child: const Icon(null),
                    ),
                    NumberDialPad(
                      onTap: () => addDigit(0),
                      numberText: '0',
                    ),
                    TextButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(
                          Size(heightValue75, heightValue75),
                        ),
                      ),
                      onPressed: () {
                        backspace();
                      },
                      child: Icon(
                        Icons.backspace_outlined,
                        color: Colors.red,
                        size: heightValue30,
                      ),
                    ),
                  ],
                ),
                HeightSpace(heightValue15),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              backgroundColor: greyScale850,
                              surfaceTintColor: greyScale850,
                              icon: Image.asset(
                                infoCircle,
                                height: value100,
                                width: value100,
                                color: whiteColor,
                              ),
                              title: Text(
                                "Caution",
                                style: TextStyle(
                                  fontSize: heightValue20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                "Are you sure you want to cancel the transaction",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: heightValue15,
                                  color: Colors.grey[600],
                                ),
                              ),
                              actions: <Widget>[
                                CustomButton(
                                  buttonText: "Yes",
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  buttonColor: primaryAppColor,
                                  buttonTextColor: secondaryAppColor,
                                ),
                                SizedBox(
                                  height: heightValue10,
                                ),
                                CustomButton(
                                  buttonText: "No",
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  buttonColor: primaryAppColor,
                                  buttonTextColor: secondaryAppColor,
                                )
                              ],
                            ));
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: heightValue30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
