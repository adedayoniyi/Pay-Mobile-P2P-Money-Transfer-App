/*nothing much here. This just asks the user for the amount they will like to add
Then it confirms their pin and updates their balance
You can implement an actual deposit feature if you want*/

import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/features/home/services/home_service.dart';
import 'package:pay_mobile_app/features/home/widgets/confirm_pin_to_send_money_dialpad.dart';
import 'package:pay_mobile_app/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_app/widgets/custom_app_bar.dart';
import 'package:pay_mobile_app/widgets/custom_button.dart';
import 'package:pay_mobile_app/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class FundWalletScreen extends StatefulWidget {
  static const String route = "/add-money";
  const FundWalletScreen({super.key});

  @override
  State<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen> {
  final TextEditingController amountController = TextEditingController();
  final HomeService homeService = HomeService();

  void fundAccontWallet() {
    final username =
        Provider.of<UserProvider>(context, listen: false).user.username;
    homeService.fundWallet(
        context: context,
        username: username,
        amount: int.parse(amountController.text),
        onLandingOnHomePage: () {});
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(
          image: logo,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: value20),
          child: Column(
            children: [
              Text(
                "Add Money",
                style: TextStyle(
                  fontSize: heightValue25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Enter the amount you will like to add",
                style: TextStyle(
                  fontSize: heightValue24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: heightValue10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Note: max = ",
                    style: TextStyle(
                      fontSize: heightValue20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₦5,000",
                    style: TextStyle(
                      fontSize: value15,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                keyboardType: TextInputType.number,
                hintText: "Enter Amount",
                controller: amountController,
              ),
              SizedBox(
                height: heightValue40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: value40),
                child: CustomButton(
                  buttonText: "Continue",
                  buttonColor: primaryAppColor,
                  buttonTextColor: secondaryAppColor,
                  onTap: () => showModalBottomSheet<dynamic>(
                    context: context,
                    enableDrag: false,
                    isDismissible: false,
                    isScrollControlled: true,
                    constraints: BoxConstraints.loose(
                      Size(screenWidth, screenHeight),
                    ),
                    builder: (context) => ConfirmPinToSendMoneyDialPad(
                      onSuccess: () {
                        fundAccontWallet();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
