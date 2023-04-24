import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/textstyle_constants.dart';
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
        fromUsername: user.username,
        toUsername: usernameController.text,
        amount: int.parse(amountController.text),
        summary: summaryController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: const Center(
            child: Text("Send Money"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Enter receipents username",
                  style: heading5GreyScale900,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: value200,
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
                              top:
                                  error == true ? heightValue20 : heightValue40,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                getTransferUsername();
                              },
                              child: Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: defaultAppColor,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
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
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                width: screenWidth,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  color: Colors.grey[300],
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    CircleAvatar(
                                      radius: 25,
                                      child: Center(
                                        child: Text(successText![0]),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 45,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          successText!,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "@${usernameController.text}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
