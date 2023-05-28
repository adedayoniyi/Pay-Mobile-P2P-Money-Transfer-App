import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/features/home/services/home_service.dart';
import 'package:money_transfer_app/features/home/widgets/confirm_pin_to_send_money_dialpad.dart';
import 'package:money_transfer_app/features/home/widgets/get_transfer_username_textfield.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/widgets/amount_text_field.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';
import 'package:money_transfer_app/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class SendMoneyScreen extends StatefulWidget {
  static const String route = '/send-money-screen';
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
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            leadingWidth: screenWidth,
            scrolledUnderElevation: 5,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Center(
                  child: Text(
                    "Send Money",
                    style: TextStyle(
                      fontSize: heightValue24,
                    ),
                  ),
                ),
                const BackButton(
                  color: Colors.transparent,
                )
              ],
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: value20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Enter receipents username",
                  style: TextStyle(
                    fontSize: heightValue24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: value220,
                          child: GetTransferUsernameTextField(
                            labelText: "Username",
                            hintText: "username",
                            prefixIcon: "@",
                            controller: usernameController,
                            errorText: error == true ? errorText : null,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: error == true ? heightValue20 : heightValue40,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              getTransferUsername();
                            },
                            child: Container(
                              height: heightValue65,
                              width: heightValue65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: defaultAppColor,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: heightValue27,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                error == false
                    ? Form(
                        key: transferKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: heightValue20),
                              child: Stack(
                                children: [
                                  Container(
                                    width: screenWidth,
                                    height: heightValue80,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(heightValue20),
                                      color: Colors.grey[300],
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: value20,
                                        ),
                                        CircleAvatar(
                                          radius: heightValue25,
                                          child: Center(
                                            child: Text(
                                              successText![0],
                                              style: TextStyle(
                                                fontSize: heightValue20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: value25,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              successText!,
                                              style: TextStyle(
                                                fontSize: heightValue23,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "@${usernameController.text}",
                                              style: TextStyle(
                                                fontSize: heightValue18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(
                                          heightValue20,
                                        ),
                                        topLeft: Radius.circular(
                                          heightValue25,
                                        ),
                                      ),
                                      child: Container(
                                        height: heightValue25,
                                        width: heightValue25,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFDFAD2C),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(
                                          heightValue25,
                                        ),
                                        topLeft: Radius.circular(
                                          heightValue20,
                                        ),
                                      ),
                                      child: Container(
                                        height: heightValue25,
                                        width: heightValue25,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF5337A5),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            AmountTextField(
                              keyboardType: TextInputType.number,
                              labelText: "Amount",
                              hintText: "Enter amount",
                              controller: amountController,
                            ),
                            CustomTextField(
                              labelText: "Description",
                              hintText: "Write short note",
                              controller: summaryController,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CustomButton(
                              buttonText: "Send Money",
                              buttonColor: defaultAppColor,
                              buttonTextColor: whiteColor,
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
        ));
  }
}
