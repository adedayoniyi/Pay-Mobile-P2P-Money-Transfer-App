import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/features/home/services/home_service.dart';
import 'package:pay_mobile_app/features/home/widgets/confirm_pin_to_send_money_dialpad.dart';
import 'package:pay_mobile_app/features/home/widgets/send_money_found_user_details_container.dart';
import 'package:pay_mobile_app/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_app/widgets/custom_app_bar.dart';
import 'package:pay_mobile_app/widgets/custom_button.dart';
import 'package:pay_mobile_app/widgets/custom_textfield.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';
import 'package:provider/provider.dart';

class SendMoneyScreen extends StatefulWidget {
  static const String route = '/send-money';
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  final HomeService homeService = HomeService();
  String? successText = '';
  String errorText = 'Invalid username';
  bool? error;
  final transferKey = GlobalKey<FormState>();

  getTransferUsername() async {
    successText = await homeService.getTransferUsername(
        context: context,
        username: usernameController.text,
        onError: () {
          setState(() {
            error = true;
          });
        });
    if (successText != '') {
      setState(() {
        error = false;
      });
    }
    setState(() {});
  }

  void transferMoney() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (transferKey.currentState!.validate()) {
      homeService.transferMoney(
        context: context,
        sendersUsername: user.username,
        recipientsUsername: usernameController.text,
        amount: int.parse(amountController.text),
        description: summaryController.text,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    amountController.dispose();
    summaryController.dispose();
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeightSpace(heightValue10),
                  Text(
                    "Send Money",
                    style: TextStyle(
                      fontSize: heightValue25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  HeightSpace(heightValue10),
                  Text(
                    "Enter receipents username",
                    style: TextStyle(
                      fontSize: heightValue24,
                    ),
                  ),
                  HeightSpace(heightValue10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: value220,
                            child: CustomTextField(
                              labelText: "Username",
                              hintText: "username",
                              prefixIcon: const Icon(Icons.alternate_email),
                              controller: usernameController,
                              errorText: error == true ? errorText : null,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          getTransferUsername();
                        },
                        child: Container(
                          height: heightValue65,
                          width: heightValue65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryAppColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.search,
                              color: secondaryAppColor,
                              size: heightValue27,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  HeightSpace(heightValue10),
                  error == false
                      ? Form(
                          key: transferKey,
                          child: Column(
                            children: [
                              SendMoneyFoundUserDetailsContainer(
                                circleAvatarText: successText![0],
                                userFullName: successText!,
                                userName: "@${usernameController.text}",
                              ),
                              HeightSpace(heightValue20),
                              CustomTextField(
                                keyboardType: TextInputType.number,
                                labelText: "Amount",
                                hintText: "Enter amount",
                                controller: amountController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                              CustomTextField(
                                labelText: "Description",
                                hintText: "Write short note",
                                controller: summaryController,
                              ),
                              HeightSpace(heightValue25),
                              CustomButton(
                                buttonText: "Send Money",
                                buttonColor: primaryAppColor,
                                buttonTextColor: secondaryAppColor,
                                borderRadius: heightValue30,
                                onTap: () => showModalBottomSheet<dynamic>(
                                  context: context,
                                  enableDrag: false,
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  constraints: BoxConstraints.loose(
                                    Size(
                                      screenWidth,
                                      screenHeight,
                                    ),
                                  ),
                                  builder: (context) =>
                                      ConfirmPinToSendMoneyDialPad(
                                    onSuccess: () {
                                      transferMoney();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          )),
    );
  }
}
