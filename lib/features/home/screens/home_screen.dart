import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_transfer_app/features/home/widgets/clip_path_bottom_right_for_balance_card.dart';
import 'package:money_transfer_app/features/home/widgets/clip_path_top_right_for_balance_card.dart';
import 'package:provider/provider.dart';

import 'package:money_transfer_app/constants/color_constants.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/features/auth/services/auth_service.dart';
import 'package:money_transfer_app/features/home/screens/send_money_screen.dart';
import 'package:money_transfer_app/features/home/services/home_service.dart';
import 'package:money_transfer_app/features/home/widgets/payment_options_column.dart';
import 'package:money_transfer_app/features/transactions/screens/transaction_details_screen.dart';
import 'package:money_transfer_app/features/transactions/widgets/transactions_card.dart';
import 'package:money_transfer_app/models/transactions.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/widgets/circular_loader.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';

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
  Stream _myStream = const Stream.empty();
  late StreamSubscription _sub = _myStream.listen((event) {});
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
    Future.delayed(const Duration(seconds: 5), () {
      _myStream = Stream.periodic(const Duration(seconds: 10), (count) {
        getUserBalance();
      });
      _sub = _myStream.listen((event) {});
    });

    Future.delayed(const Duration(seconds: 160), () {
      _sub.cancel();
      print("Stream Cancled");
    });

    getUserBalance();
    checkIfUserHasPin();
    obtainTokenAndUserData();
    _future = getAllTransactions();
    Future.delayed(const Duration(seconds: 5), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
    scrollController.addListener(() {
      if (scrollController.position.isScrollingNotifier.value) {
        print('User is scrolling');
        _myStream = Stream.periodic(const Duration(seconds: 10), (count) {
          getUserBalance();
        });
        _sub = _myStream.listen((event) {});
      } else {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
    scrollController.dispose();
  }

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
                      Stack(
                        children: [
                          Container(
                            height: heightValue230,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(heightValue30),
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
                                                    fontSize: heightValue25,
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
                                                      fontSize: heightValue20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "@ ${user.username}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: whiteColor,
                                                      fontSize: heightValue18,
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
                                              fontSize: heightValue25,
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
                              ),
                            ),
                          ),
                          const ClipPathTopRightForBalanceCard(),
                          const ClipPathBottomRightForBalanceCard(),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(
                                  heightValue30,
                                ),
                                topLeft: Radius.circular(
                                  heightValue50,
                                ),
                              ),
                              child: Container(
                                height: heightValue50,
                                width: heightValue50,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFA9224A),
                                ),
                              ),
                            ),
                          )
                        ],
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
                                      buttonColor: defaultAppColor,
                                      buttonTextColor: whiteColor,
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
