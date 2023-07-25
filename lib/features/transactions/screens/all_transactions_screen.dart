import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/features/home/screens/send_money_screen.dart';
import 'package:pay_mobile_app/features/transactions/screens/transaction_details_screen.dart';
import 'package:pay_mobile_app/features/transactions/services/transactions_services.dart';
import 'package:pay_mobile_app/features/transactions/widgets/transactions_card.dart';
import 'package:pay_mobile_app/features/transactions/models/transactions.dart';
import 'package:pay_mobile_app/widgets/circular_loader.dart';
import 'package:pay_mobile_app/widgets/custom_button.dart';

class TransactionsScreen extends StatefulWidget {
  static const String route = "/transactions-screen";
  const TransactionsScreen({super.key});
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final ScrollController scrollController = ScrollController();
  List<Transactions> transactions = [];
  final TransactionServices transactionServices = TransactionServices();
  late Future _future;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _future = getAllTransactions();
    }
  }

  getAllTransactions() async {
    transactions = await transactionServices.getAllTransactions(
      context: context,
    );
    setState(() {});
  }

  String getTransactionDateText(DateTime transactionDate) {
    DateTime now = DateTime.now();
    int hoursDiff = now.difference(transactionDate).inHours;
    int daysDiff = now.difference(transactionDate).inDays;
    String formattedDate = DateFormat.yMMMd().format(transactionDate);
    if (hoursDiff < 3) {
      return "Recent";
    } else if (daysDiff == 0) {
      return "Today";
    } else if (daysDiff == 1) {
      return "Yesterday";
    } else {
      return formattedDate;
    }
  }

  Map<String, List<Transactions>> groupTransactionsByDateText(
      List<Transactions> transactions) {
    Map<String, List<Transactions>> groups = {};
    for (Transactions transaction in transactions) {
      String dateText = getTransactionDateText(transaction.createdAt);
      if (groups.containsKey(dateText)) {
        groups[dateText]!.add(transaction);
      } else {
        groups[dateText] = [transaction];
      }
    }
    return groups;
  }

  List<String> getTrnxSummary(transactionData) {
    if (transactionData.trnxType == "Credit") {
      return [
        "From ${transactionData.fullNameTransactionEntity} Reference:${transactionData.reference}",
        "assets/icons/credit_icon.png"
      ];
    } else if (transactionData.trnxType == "Debit") {
      return [
        "To ${transactionData.fullNameTransactionEntity} Reference:${transactionData.reference}",
        "assets/icons/debit_icon.png"
      ];
    } else if (transactionData.trnxType == "Wallet Funding") {
      return [
        "You Funded Your Wallet. Reference:${transactionData.reference}",
        "assets/icons/add_icon.png"
      ];
    } else {
      return ["Hello"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 5,
        title: Center(
          child: Text(
            "Transactions",
            style: TextStyle(
              fontSize: heightValue25,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return transactions.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: value20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/empty_list.png"),
                        Text(
                          "You've not made any transactions",
                          style: TextStyle(
                            fontSize: heightValue18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: heightValue40,
                        ),
                        CustomButton(
                          buttonText: "Transfer Now",
                          buttonColor: primaryAppColor,
                          buttonTextColor: secondaryAppColor,
                          borderRadius: heightValue30,
                          onTap: () {
                            Navigator.pushNamed(context, SendMoneyScreen.route);
                          },
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: value20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: heightValue10,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            displacement: 100,
                            onRefresh: () => getAllTransactions(),
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount:
                                  groupTransactionsByDateText(transactions)
                                      .length,
                              itemBuilder: (BuildContext context, int index) {
                                List<String> keys =
                                    groupTransactionsByDateText(transactions)
                                        .keys
                                        .toList();
                                String key = keys[index];
                                List<Transactions> transactionsList =
                                    groupTransactionsByDateText(
                                        transactions)[key]!;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      key,
                                      style: TextStyle(
                                        fontSize: heightValue18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: transactionsList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final transactionData =
                                            transactionsList[index];
                                        return GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                            context,
                                            TransactionDetailsScreen.route,
                                            arguments: transactionData,
                                          ),
                                          child: TransactionsCard(
                                            transactionTypeImage:
                                                getTrnxSummary(
                                                    transactionData)[1],
                                            transactionType:
                                                transactionData.trnxType,
                                            trnxSummary: getTrnxSummary(
                                                transactionData)[0],
                                            amount: transactionData.amount,
                                            amountColorBasedOnTransactionType:
                                                transactionData.trnxType ==
                                                        "Debit"
                                                    ? Colors.red
                                                    : Colors.green,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          } else {}
          return const CircularLoader();
        },
      ),
    );
  }
}
