import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pay_mobile_app/config/routes/custom_push_navigators.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/features/home/screens/comming_soon_screen.dart';
import 'package:pay_mobile_app/features/home/widgets/add_send_funds_container.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';
import 'package:pay_mobile_app/features/home/widgets/payment_containers.dart';
import 'package:provider/provider.dart';

import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/features/auth/services/auth_service.dart';
import 'package:pay_mobile_app/features/home/screens/send_money_screen.dart';
import 'package:pay_mobile_app/features/home/services/home_service.dart';
import 'package:pay_mobile_app/features/transactions/screens/transaction_details_screen.dart';
import 'package:pay_mobile_app/features/transactions/widgets/transactions_card.dart';
import 'package:pay_mobile_app/features/transactions/models/transactions.dart';
import 'package:pay_mobile_app/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_app/widgets/circular_loader.dart';
import 'package:pay_mobile_app/widgets/custom_button.dart';

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
  List<Transactions> transactions = [];
  late Future _future;
  final ScrollController scrollController = ScrollController();

  getUserBalance() async {
    getCreditNotifications();
    getAllTransactions();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    balance = await homeService.getUserBalance(
      context: context,
      username: user.username,
    );

    if (mounted) {
      setState(() {});
    }
  }

  getAllTransactions() async {
    transactions = await homeService.getAllTransactions(
      context: context,
    );
    if (mounted) {
      setState(() {});
    }
  }

  void checkIfUserHasPin() {
    homeService.checkIfUserHasSetPin(context);
  }

  obtainTokenAndUserData() async {
    await authService.obtainTokenAndUserData(context);
  }

  getCreditNotifications() {
    homeService.creditNotification(
        context: context,
        onSuccess: () {
          Future.delayed(const Duration(seconds: 6), () {
            deleteNotification();
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });
        });
  }

  deleteNotification() {
    homeService.deleteNotification(context: context);
  }

  @override
  void initState() {
    super.initState();

    getUserBalance();
    checkIfUserHasPin();
    obtainTokenAndUserData();
    _future = getAllTransactions();
    Future.delayed(const Duration(seconds: 5), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  List<String> paymentIcons = [
    mobileIcon,
    budgetIcon,
    electricityIcon,
    wifiIcon,
    billsIcon,
    moreIcon,
  ];
  List<String> paymentText = [
    "Airtime",
    "Budget",
    "Electricity",
    "Data",
    "Bills",
    "More",
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: value20),
          child: Column(
            children: [
              RefreshIndicator(
                displacement: 80,
                onRefresh: () => getUserBalance(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: heightValue15,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: heightValue25,
                                    // backgroundColor: whiteColor,
                                    backgroundImage:
                                        const AssetImage(gradientCircle),
                                    child: Center(
                                        child: Text(
                                      user.fullname[0],
                                      style: TextStyle(
                                          color: secondaryAppColor,
                                          fontSize: heightValue25,
                                          fontWeight: FontWeight.bold),
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
                                          fontSize: heightValue18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "@ ${user.username}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: heightValue15,
                                        ),
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
                          SizedBox(
                            height: heightValue10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Total Balance",
                                  style: TextStyle(
                                    color: greyScale400,
                                    fontSize: heightValue20,
                                  ),
                                ),
                                Text(
                                  "₦ ${amountFormatter.format(balance)}",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: heightValue50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      HeightSpace(heightValue10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AddSendFundsContainers(
                            text: "Add",
                            icon: addIcon,
                            onTap: () => namedNav(context, "/add-money"),
                          ),
                          AddSendFundsContainers(
                            text: "Send",
                            icon: sendIcon,
                            onTap: () => namedNav(context, "/send-money"),
                          ),
                        ],
                      ),
                      HeightSpace(heightValue20),
                      const Divider(),
                      HeightSpace(heightValue20),
                      Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: heightValue25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      HeightSpace(heightValue10),
                      SizedBox(
                        height: heightValue130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: paymentIcons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => namedNav(
                                context,
                                CommingSoonScreen.route,
                              ),
                              child: PaymentContainers(
                                icon: paymentIcons[index],
                                color: whiteColor,
                                text: paymentText[index],
                              ),
                            );
                          },
                        ),
                      ),
                      HeightSpace(heightValue20),
                      Text(
                        "Transactions",
                        style: TextStyle(
                          fontSize: heightValue35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: _future,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return transactions.isEmpty
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: heightValue10,
                                  ),
                                  Image.asset(
                                    "assets/images/empty_list.png",
                                    height: heightValue150,
                                  ),
                                  Text(
                                    "You've not made any transactions",
                                    style: TextStyle(
                                      fontSize: heightValue18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: heightValue10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: value60),
                                    child: CustomButton(
                                      buttonText: "Transfer Now",
                                      buttonColor: primaryAppColor,
                                      buttonTextColor: secondaryAppColor,
                                      borderRadius: heightValue30,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          SendMoneyScreen.route,
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: () => getAllTransactions(),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: scrollController,
                                itemCount: transactions.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final transactionData = transactions[index];
                                  List<String> getTrnxSummary(transactionData) {
                                    if (transactionData.trnxType == "Credit") {
                                      return [
                                        "From ${transactionData.fullNameTransactionEntity} Reference:${transactionData.reference}",
                                        "assets/icons/credit_icon.png"
                                      ];
                                    } else if (transactionData.trnxType ==
                                        "Debit") {
                                      return [
                                        "To ${transactionData.fullNameTransactionEntity} Reference:${transactionData.reference}",
                                        "assets/icons/debit_icon.png"
                                      ];
                                    } else if (transactionData.trnxType ==
                                        "Wallet Funding") {
                                      return [
                                        "You Funded Your Wallet. Reference:${transactionData.reference}",
                                        "assets/icons/add_icon.png"
                                      ];
                                    } else {
                                      return ["Hello"];
                                    }
                                  }

                                  return GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      TransactionDetailsScreen.route,
                                      arguments: transactionData,
                                    ),
                                    child: TransactionsCard(
                                      transactionTypeImage:
                                          getTrnxSummary(transactionData)[1],
                                      transactionType: transactionData.trnxType,
                                      trnxSummary:
                                          getTrnxSummary(transactionData)[0],
                                      amount: transactionData.amount,
                                      amountColorBasedOnTransactionType:
                                          transactionData.trnxType == "Debit"
                                              ? Colors.red
                                              : Colors.green,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                  }
                  return const Expanded(child: CircularLoader());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
