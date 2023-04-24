import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/textstyle_constants.dart';
import 'package:money_transfer_app/features/home/screens/send_money_screen.dart';
import 'package:money_transfer_app/features/transactions/services/transactions_services.dart';
import 'package:money_transfer_app/features/transactions/widgets/transactions_card.dart';
import 'package:money_transfer_app/models/transactions.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';

class TransactionsScreen extends StatefulWidget {
  static const String route = "/transactions-screen";
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<Transactions>? transactions;
  final TransactionServices transactionServices = TransactionServices();
  late Future _future;

  @override
  void initState() {
    super.initState();
    _future = getAllTransactions();
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
        title: const Center(child: Text("Transactions")),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return transactions == null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: value20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/empty_list.png"),
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
                            })
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: value20),
                    child: Column(
                      children: [
                        Expanded(
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
                        ),
                      ],
                    ),
                  );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
