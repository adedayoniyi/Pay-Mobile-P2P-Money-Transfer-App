// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/features/auth/services/auth_service.dart';
import 'package:pay_mobile_app/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';
import 'package:pay_mobile_app/widgets/number_dial_pad.dart';
import 'package:pay_mobile_app/widgets/pin_input_field.dart';
import 'package:pay_mobile_app/widgets/width_space.dart';
import 'package:provider/provider.dart';

class CreateLoginPinScreen extends StatefulWidget {
  static const String route = "/create-login-pin-screen";
  const CreateLoginPinScreen({super.key});

  @override
  State<CreateLoginPinScreen> createState() => _CreateLoginPinScreenState();
}

class _CreateLoginPinScreenState extends State<CreateLoginPinScreen> {
  var selectedindex = 0;
  String pin = '';
  String confirmPin = '';
  String hello = "";

  final AuthService authService = AuthService();

  void createPinUser() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    authService.createPin(
      context: context,
      pin: pin,
      username: user.username,
      confirmPin: confirmPin,
    );
  }

  getUserData() async {
    await authService.obtainTokenAndUserData(context);
  }

  addDigit(int digit) {
    if (pin.length > 3) {
      return;
    }
    setState(() {
      pin = pin + digit.toString();
      print('pin is $pin');
      selectedindex = pin.length;
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

  addDigitForConfirm(int digit) {
    if (confirmPin.length > 3) {
      //createPinUser();
      return;
    }

    setState(() {
      confirmPin = confirmPin + digit.toString();
      print('Confirm pin is $confirmPin');
      selectedindex = confirmPin.length;
      if (confirmPin.length > 3) {
        createPinUser();
        getUserData();
      }
    });
  }

  backspaceForConfirm() {
    if (confirmPin.isEmpty) {
      return;
    }
    setState(() {
      confirmPin = confirmPin.substring(0, confirmPin.length - 1);
      selectedindex = confirmPin.length;
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
                  logo,
                  height: heightValue65,
                ),
                HeightSpace(heightValue25),
                Row(
                  children: [
                    Text(
                      "Welcome, ",
                      style: TextStyle(
                        fontSize: heightValue30,
                      ),
                    ),
                    WidthSpace(value10),
                    Icon(
                      Icons.waving_hand,
                      color: Colors.amber,
                      size: heightValue30,
                    ),
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
                HeightSpace(heightValue10),
                pin.length > 3
                    ? Text(
                        "Confirm your 4 digit pin",
                        style: TextStyle(fontSize: heightValue23),
                      )
                    : Text(
                        "Create 4 digit pin for your account",
                        style: TextStyle(fontSize: heightValue22),
                      ),
                HeightSpace(heightValue30),
                pin.length > 3
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PinInputField(
                            index: 0,
                            selectedIndex: selectedindex,
                            pin: confirmPin,
                          ),
                          PinInputField(
                              index: 1,
                              selectedIndex: selectedindex,
                              pin: confirmPin),
                          PinInputField(
                              index: 2,
                              selectedIndex: selectedindex,
                              pin: confirmPin),
                          PinInputField(
                              index: 3,
                              selectedIndex: selectedindex,
                              pin: confirmPin),
                        ],
                      )
                    : Row(
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
                HeightSpace(heightValue20),
                pin.length > 3
                    ? Column(
                        children: [
                          HeightSpace(heightValue20),
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
                          HeightSpace(heightValue20),
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
                          HeightSpace(heightValue20),
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
                                  backspaceForConfirm();
                                },
                                child: const Icon(null),
                              ),
                              NumberDialPad(
                                onTap: () => addDigitForConfirm(0),
                                numberText: '0',
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(heightValue75, heightValue75),
                                  ),
                                ),
                                onPressed: () {
                                  backspaceForConfirm();
                                },
                                child: Icon(
                                  Icons.backspace_outlined,
                                  color: Colors.red,
                                  size: heightValue30,
                                ),
                              ),
                            ],
                          ),
                          HeightSpace(heightValue10),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
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
                      )
                    : Column(
                        children: [
                          HeightSpace(heightValue20),
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
                          HeightSpace(heightValue20),
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
                          HeightSpace(heightValue20),
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
                                onPressed: () => backspace(),
                                child: const Icon(null),
                              ),
                              NumberDialPad(
                                  onTap: () => addDigit(0), numberText: '0'),
                              TextButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(heightValue75, heightValue75),
                                  ),
                                ),
                                onPressed: () => backspace(),
                                child: Icon(
                                  Icons.backspace_outlined,
                                  color: Colors.red,
                                  size: heightValue30,
                                ),
                              ),
                            ],
                          ),
                          HeightSpace(heightValue25),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
