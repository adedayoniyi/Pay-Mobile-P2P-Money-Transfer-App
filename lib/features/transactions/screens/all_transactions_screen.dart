import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/features/home/screens/send_money_screen.dart';
import 'package:money_transfer_app/features/transactions/screens/transaction_details_screen.dart';
import 'package:money_transfer_app/features/transactions/services/transactions_services.dart';
import 'package:money_transfer_app/features/transactions/widgets/transactions_card.dart';
import 'package:money_transfer_app/models/transactions.dart';
import 'package:money_transfer_app/widgets/circular_loader.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';

class TransactionsScreen extends StatefulWidget {
  static const String route = "/transactions-screen";
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
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
                            buttonColor: defaultAppColor,
                            buttonTextColor: whiteColor,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SendMoneyScreen.route);
                            })
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
