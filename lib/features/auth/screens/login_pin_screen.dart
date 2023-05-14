// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/features/auth/services/auth_service.dart';
import 'package:money_transfer_app/features/profile/services/profile_services.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';
import 'package:money_transfer_app/widgets/number_dial_pad.dart';
import 'package:money_transfer_app/widgets/pin_input_field.dart';
import 'package:provider/provider.dart';

class LoginPinScreen extends StatefulWidget {
  const LoginPinScreen({super.key});

  @override
  State<LoginPinScreen> createState() => _LoginPinScreenState();
}

class _LoginPinScreenState extends State<LoginPinScreen> {
  final AuthService authService = AuthService();
  final ProfileServices profileServices = ProfileServices();
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
        loginUsingPersonalPin();
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

  void logOut() {
    profileServices.logOut(context);
  }

  void loginUsingPersonalPin() {
    final username =
        Provider.of<UserProvider>(context, listen: false).user.username;
    authService.loginUsingPin(
      context: context,
      pin: pin,
      username: username,
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
                  height: heightValue20,
                ),
                Image.asset(
                  "assets/images/full_logo.png",
                  height: heightValue150,
                ),
                SizedBox(
                  height: heightValue20,
                ),
                Row(
                  children: [
                    Text(
                      "Welcome back",
                      style: TextStyle(
                        fontSize: heightValue30,
                      ),
                    ),
                    SizedBox(
                      width: value20,
                    ),
                    Icon(
                      Icons.waving_hand,
                      color: Colors.amber,
                      size: value30,
                    )
                  ],
                ),
                SizedBox(
                  height: heightValue10,
                ),
                Text(
                  user.fullname,
                  style: TextStyle(
                    fontSize: heightValue35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: heightValue10,
                ),
                Text(
                  "Enter your 4 digit pin to proceed",
                  style: TextStyle(fontSize: heightValue25),
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
                SizedBox(
                  height: heightValue20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberDialPad(onTap: () => addDigit(1), numberText: '1'),
                    NumberDialPad(onTap: () => addDigit(2), numberText: '2'),
                    NumberDialPad(onTap: () => addDigit(3), numberText: '3'),
                  ],
                ),
                SizedBox(
                  height: heightValue20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberDialPad(onTap: () => addDigit(4), numberText: '4'),
                    NumberDialPad(onTap: () => addDigit(5), numberText: '5'),
                    NumberDialPad(onTap: () => addDigit(6), numberText: '6'),
                  ],
                ),
                SizedBox(
                  height: heightValue20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberDialPad(onTap: () => addDigit(7), numberText: '7'),
                    NumberDialPad(onTap: () => addDigit(8), numberText: '8'),
                    NumberDialPad(onTap: () => addDigit(9), numberText: '9'),
                  ],
                ),
                SizedBox(
                  height: heightValue20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberDialPad(onTap: () {}, numberText: ''),
                    NumberDialPad(onTap: () => addDigit(0), numberText: '0'),
                    TextButton(
                      //height: double.maxFinite,
                      onPressed: () {
                        backspace();
                      },
                      child: Icon(Icons.backspace_outlined,
                          color: Colors.black.withBlue(40), size: 30),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              backgroundColor: whiteColor,
                              surfaceTintColor: whiteColor,
                              icon: Image.asset(
                                "assets/icons/info-circle.png",
                                height: heightValue100,
                                width: heightValue100,
                              ),
                              title: Text("Caution",
                                  style: TextStyle(
                                      fontSize: value18,
                                      fontWeight: FontWeight.bold)),
                              content: Text(
                                "Are you sure you want to logout",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: heightValue13,
                                    color: Colors.grey[600]),
                              ),
                              actions: <Widget>[
                                CustomButton(
                                  buttonText: "Yes",
                                  onTap: () {
                                    logOut();
                                  },
                                  buttonColor: defaultAppColor,
                                  buttonTextColor: whiteColor,
                                ),
                                SizedBox(
                                  height: heightValue10,
                                ),
                                CustomButton(
                                  buttonText: "Cancel",
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  buttonColor: defaultAppColor,
                                  buttonTextColor: whiteColor,
                                )
                              ],
                            ));
                  },
                  child: Text(
                    "Sign Out",
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
