// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/textstyle_constants.dart';
import 'package:money_transfer_app/features/profile/services/profile_services.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/widgets/number_dial_pad.dart';
import 'package:money_transfer_app/widgets/pin_input_field.dart';
import 'package:provider/provider.dart';

class ChangeLoginPinScreen extends StatefulWidget {
  static const String route = "/change-login-pin-screen";
  const ChangeLoginPinScreen({super.key});

  @override
  State<ChangeLoginPinScreen> createState() => _ChangeLoginPinScreenState();
}

class _ChangeLoginPinScreenState extends State<ChangeLoginPinScreen> {
  var selectedindex = 0;
  String oldPin = '';
  String newPin = '';

  final ProfileServices profileServices = ProfileServices();

  void changeLoginPin() {
    final username =
        Provider.of<UserProvider>(context, listen: false).user.username;
    profileServices.changeLoginPin(
      context: context,
      username: username,
      oldPin: oldPin,
      newPin: newPin,
    );
  }

  addDigit(int digit) {
    if (oldPin.length > 3) {
      return;
    }
    setState(() {
      oldPin = oldPin + digit.toString();
      print('oldPin is $oldPin');
      selectedindex = oldPin.length;
    });
  }

  backspace() {
    if (oldPin.isEmpty) {
      return;
    }
    setState(() {
      oldPin = oldPin.substring(0, oldPin.length - 1);
      selectedindex = oldPin.length;
    });
  }

  addDigitForConfirm(int digit) {
    if (newPin.length > 3) {
      //createPinUser();
      return;
    }

    setState(() {
      newPin = newPin + digit.toString();
      print('newPin pin is $newPin');
      selectedindex = newPin.length;
      if (newPin.length > 3) {
        changeLoginPin();
      }
    });
  }

  backspaceForConfirm() {
    if (newPin.isEmpty) {
      return;
    }
    setState(() {
      newPin = newPin.substring(0, newPin.length - 1);
      selectedindex = newPin.length;
    });
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
                  height: heightValue50,
                ),
                Image.asset(
                  "assets/images/full_logo.png",
                  height: value110,
                ),
                SizedBox(
                  height: heightValue20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome, ",
                      style: TextStyle(
                        fontSize: value25,
                      ),
                    ),
                    Text(
                      user.fullname,
                      style: heading5GreyScale900,
                    ),
                  ],
                ),
                SizedBox(
                  height: heightValue20,
                ),
                oldPin.length > 3
                    ? Text(
                        "Enter your new pin",
                        style: heading5GreyScale900,
                      )
                    : Text(
                        "Enter your old pin",
                        style: heading5GreyScale900,
                      ),
                SizedBox(
                  height: heightValue30,
                ),
                oldPin.length > 3
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PinInputField(
                            index: 0,
                            selectedIndex: selectedindex,
                            pin: newPin,
                          ),
                          PinInputField(
                              index: 1,
                              selectedIndex: selectedindex,
                              pin: newPin),
                          PinInputField(
                              index: 2,
                              selectedIndex: selectedindex,
                              pin: newPin),
                          PinInputField(
                              index: 3,
                              selectedIndex: selectedindex,
                              pin: newPin),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PinInputField(
                            index: 0,
                            selectedIndex: selectedindex,
                            pin: oldPin,
                          ),
                          PinInputField(
                              index: 1,
                              selectedIndex: selectedindex,
                              pin: oldPin),
                          PinInputField(
                              index: 2,
                              selectedIndex: selectedindex,
                              pin: oldPin),
                          PinInputField(
                              index: 3,
                              selectedIndex: selectedindex,
                              pin: oldPin),
                        ],
                      ),
                SizedBox(
                  height: heightValue20,
                ),
                oldPin.length > 3
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(1),
                                  numberText: '1'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(2),
                                  numberText: '2'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(3),
                                  numberText: '3'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(4),
                                  numberText: '4'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(5),
                                  numberText: '5'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(6),
                                  numberText: '6'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(7),
                                  numberText: '7'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(8),
                                  numberText: '8'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(9),
                                  numberText: '9'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                onTap: () {},
                                numberText: '',
                              ),
                              NumberDialPad(
                                onTap: () => addDigitForConfirm(0),
                                numberText: '0',
                              ),
                              TextButton(
                                onPressed: () {
                                  backspaceForConfirm();
                                },
                                child: Icon(Icons.backspace_outlined,
                                    color: Colors.black.withBlue(40), size: 30),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: value30,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigit(1), numberText: '1'),
                              NumberDialPad(
                                  onTap: () => addDigit(2), numberText: '2'),
                              NumberDialPad(
                                  onTap: () => addDigit(3), numberText: '3'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigit(4), numberText: '4'),
                              NumberDialPad(
                                  onTap: () => addDigit(5), numberText: '5'),
                              NumberDialPad(
                                  onTap: () => addDigit(6), numberText: '6'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigit(7), numberText: '7'),
                              NumberDialPad(
                                  onTap: () => addDigit(8), numberText: '8'),
                              NumberDialPad(
                                  onTap: () => addDigit(9), numberText: '9'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(onTap: () {}, numberText: ''),
                              NumberDialPad(
                                  onTap: () => addDigit(0), numberText: '0'),
                              TextButton(
                                onPressed: () => backspace(),
                                child: Icon(
                                  Icons.backspace_outlined,
                                  color: Colors.black.withBlue(40),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: heightValue15,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: value30,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
