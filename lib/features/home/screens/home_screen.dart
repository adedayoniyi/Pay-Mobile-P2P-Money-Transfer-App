import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/color_constants.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/textstyle_constants.dart';
import 'package:money_transfer_app/features/auth/services/auth_service.dart';
import 'package:money_transfer_app/features/home/screens/send_money_screen.dart';
import 'package:money_transfer_app/features/home/services/home_service.dart';
import 'package:money_transfer_app/features/home/widgets/payment_options_column.dart';
import 'package:money_transfer_app/features/transactions/widgets/transactions_card.dart';
import 'package:money_transfer_app/models/transactions.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home-screens';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeService homeService = HomeService();
  final AuthService authService = AuthService();
  int? balance = 0;
  String naira = '';
  List<Transactions>? transactions;
  late Future _future;

  getUserBalance() async {
    getAllTransactions();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    balance = await homeService.getUserBalance(
      context: context,
      username: user.username,
    );
    setState(() {});
  }

  getAllTransactions() async {
    transactions = await homeService.getAllTransactions(
      context: context,
    );
    setState(() {});
  }

  void checkIfUserHasPin() {
    homeService.checkIfUserHasSetPin(context);
  }

  getUserData() async {
    await authService.getUserData(context: context);
  }

  @override
  void initState() {
    super.initState();
    _future = getUserBalance();
    checkIfUserHasPin();
    getUserData();
    Future.delayed(const Duration(seconds: 5), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              RefreshIndicator(
                onRefresh: () => getUserBalance(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: heightValue15,
                      ),
                      Container(
                        height: heightValue220,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(value30),
                          color: defaultAppColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(value10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: value25,
                                            backgroundColor: whiteColor,
                                            child: Center(
                                                child: Text(
                                              user.fullname[0],
                                              style: TextStyle(
                                                color: defaultAppColor,
                                                fontSize: value18,
                                              ),
                                            )),
                                          ),
                                          SizedBox(
                                            width: value10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Hi, ${user.fullname}",
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: value18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "@${user.username}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: value15),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/icons/notification.png",
                                        height: heightValue30,
                                        color: whiteColor,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: heightValue10,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Total Balance",
                                        style: TextStyle(
                                            color: greyScale400,
                                            fontSize: value25),
                                      ),
                                      Text(
                                        "₦ $balance",
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: value48,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: heightValue20,
                      ),
                      const PaymentOptionsColumn(),
                      SizedBox(
                        height: heightValue10,
                      ),
                      Text(
                        "Transactions",
                        style: TextStyle(
                            fontSize: value35, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: _future,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return transactions == null
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: heightValue20,
                                  ),
                                  Image.asset(
                                    "assets/images/empty_list.png",
                                    height: heightValue200,
                                  ),
                                  Text(
                                    "Nothing to see here",
                                    style: textRegularNormal,
                                  ),
                                  SizedBox(
                                    height: heightValue40,
                                  ),
                                  CustomButton(
                                    buttonText: "Transfer Now",
                                    buttonColor: defaultAppColor,
                                    buttonTextColor: whiteColor,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, SendMoneyScreen.route);
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: () => getAllTransactions(),
                              child: ListView.builder(
                                itemCount: transactions!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final transactionData = transactions![index];
                                  return TransactionsCard(
                                    transactionTypeImage:
                                        transactionData.trnxType == "Credit"
                                            ? "assets/icons/credit_icon.png"
                                            : "assets/icons/debit_icon.png",
                                    transactionType: transactionData.trnxType,
                                    trnxSummary: transactionData.trnxSummary,
                                    amount: transactionData.amount,
                                    amountColorBasedOnTransactionType:
                                        transactionData.trnxType == "Credit"
                                            ? Colors.green
                                            : Colors.red,
                                  );
                                },
                              ),
                            ),
                          );
                  }
                  return Expanded(
                      child: const Center(child: CircularProgressIndicator()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
