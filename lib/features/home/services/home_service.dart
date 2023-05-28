// ignore_for_file: avoid_print, use_build_context_synchronously, unused_catch_clause

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/constants/error_handler.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/utils.dart';
import 'package:money_transfer_app/features/auth/screens/create_login_pin_screen.dart';
import 'package:money_transfer_app/models/transactions.dart';
import 'package:money_transfer_app/models/transfer.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/widgets/main_app.dart';
import 'package:provider/provider.dart';

class HomeService {
  Future getUserBalance({
    required BuildContext context,
    required String username,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    int balance = 0;
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/balance/$username'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': userToken,
          }).timeout(const Duration(seconds: 25));

      //print(res.statusCode);
      switch (res.statusCode) {
        case 200:
          balance = jsonDecode(res.body)['message'];
          break;
        case 500:
          showSnackBar(context, jsonDecode(res.body));
      }
    } on TimeoutException catch (e) {
      showTimeOutError(
        context: context,
      );
    } on SocketException catch (e) {
      showNoInternetError(
        context: context,
      );
    } on Error catch (e) {
      print('Balance Error: $e');
    }
    return balance;
  }

  Future getTransferUsername({
    required BuildContext context,
    required String username,
    required VoidCallback onError,
  }) async {
    String successText = '';
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http.get(
          Uri.parse('$uri/api/getUsernameFortransfer/$username'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': userToken,
          }).timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');
      switch (res.statusCode) {
        case 200:
          successText = jsonDecode(res.body)['message'];
          break;
        case 400:
          onError();
          break;
        case 500:
          showSnackBar(context, jsonDecode(res.body));
      }
    } on TimeoutException catch (e) {
      showTimeOutError(
        context: context,
      );
    } on SocketException catch (e) {
      showNoInternetError(
        context: context,
      );
    } on Error catch (e) {
      print('Get Username Error: $e');
    }
    return successText;
  }

  void transferMoney({
    required BuildContext context,
    required String sendersUsername,
    required String recipientsUsername,
    required int amount,
    required String description,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      Transfer transfer = Transfer(
        sendersUsername: sendersUsername,
        recipientsUsername: recipientsUsername,
        amount: amount,
        description: description,
      );
      showDialogLoader(context);

      http.Response res = await http
          .post(
            Uri.parse("$uri/api/transactions/transfer"),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              'x-auth-token': userToken,
            },
            body: transfer.toJson(),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');
      print(res.statusCode);

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            showAlertMessage(
                context: context,
                title: "Transfer successful",
                message:
                    "You have successfully sent ₦$amount to $recipientsUsername",
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                  showMaterialBanner(
                    context: context,
                    image: "assets/images/full_logo.png",
                    description: "Transfer successful",
                    amount: "-₦$amount",
                    amountColor: Colors.red,
                    shortDesc: "@$recipientsUsername",
                    prefix: "To ",
                  );
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainApp.route, (route) => false,
                      arguments: 0);
                });
          });
    } on TimeoutException catch (e) {
      showTimeOutError(
        context: context,
        popDialogAndLoader: true,
      );
    } on SocketException catch (e) {
      showNoInternetError(
        context: context,
        popDialogAndLoader: true,
      );
    } on Error catch (e) {
      print('Transfer Error: $e');
    }
  }

  Future<List<Transactions>> getAllTransactions({
    required BuildContext context,
  }) async {
    List<Transactions> transactions = [];
    final username =
        Provider.of<UserProvider>(context, listen: false).user.username;
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      //showDialogLoader(context);
      http.Response res = await http.get(
        Uri.parse("$uri/api/getTransactions/$username"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userToken,
        },
      ).timeout(const Duration(seconds: 25));

      //Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            transactions = (json.decode(res.body) as List)
                .map((data) => Transactions.fromJson(data))
                .toList();
          });
    } on TimeoutException catch (e) {
      print("Time out");
      // showTimeOutError(
      // context: context,
      // title: "Time Out",
      // message: "Connection time out. Try again",
      // onTap: () {
      // Navigator.pop(context);
      // });
    } on SocketException catch (e) {
      print("No internet");
      // showNoInternetError(
      // context: context,
      // title: "No Internet",
      // message: "Please connect to the internet",
      // onTap: () {
      // Navigator.pop(context);
      // });
    } on Error catch (e) {
      print('Get All Transactions Error: $e');
    }
    return transactions;
  }

  void checkIfUserHasSetPin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0), () {
      if (Provider.of<UserProvider>(context, listen: false).user.pin.isEmpty) {
        showModalBottomSheet<dynamic>(
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
          builder: (context) => const CreateLoginPinScreen(),
        );
      }
    });
  }

  void confirmPinBeforeTransfer({
    required BuildContext context,
    required String pin,
    required String username,
    required VoidCallback onSuccess,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
            Uri.parse('$uri/api/loginUsingPin/$username'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              'x-auth-token': userToken,
            },
            body: jsonEncode({
              'pin': pin,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            onSuccess();
          });
    } on TimeoutException catch (e) {
      showTimeOutError(
        context: context,
        popDialogAndLoader: true,
      );
    } on SocketException catch (e) {
      showNoInternetError(
        context: context,
        popDialogAndLoader: true,
      );
    } on Error catch (e) {
      print('Confirm Pin Before Transfer Error: $e');
    }
  }

  void fundWallet({
    required BuildContext context,
    required String username,
    required int amount,
    required VoidCallback onLandingOnHomePage,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
            Uri.parse('$uri/api/fundWallet/$username'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              'x-auth-token': userToken,
            },
            body: jsonEncode({
              'amount': amount,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            print(res.statusCode);
            showMaterialBanner(
              context: context,
              image: "assets/images/full_logo.png",
              description: "Credit Successful",
              amount: "₦$amount",
              amountColor: Colors.green,
              shortDesc: "Added ₦$amount to balance",
              isFromTo: false,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainApp.route,
              (route) => false,
              arguments: 0,
            );
          });
    } on TimeoutException catch (e) {
      showTimeOutError(
        context: context,
        popDialogAndLoader: true,
      );
    } on SocketException catch (e) {
      showNoInternetError(
        context: context,
        popDialogAndLoader: true,
      );
    } on Error catch (e) {
      print('Fund Wallet Error: $e');
    }
  }

  void creditNotification({
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.get(
          Uri.parse("$uri/api/credit-notification/${user.username}"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': user.token,
          }).timeout(const Duration(seconds: 25));

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            if (jsonDecode(res.body) == null) {
              print("No Notifications");
            } else {
              showMaterialBanner(
                context: context,
                image: "assets/images/full_logo.png",
                description: "Credit Successful",
                amount: "+₦${jsonDecode(res.body)["amount"]}",
                amountColor: Colors.green,
                shortDesc: "${jsonDecode(res.body)["sendersName"]}",
                prefix: "From ",
              );
              onSuccess();
            }
          });
    } catch (e) {
      print("Notification Error:$e");
    }
  }

  void deleteNotification({
    required BuildContext context,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http
          .post(Uri.parse("$uri/api/deleteNotification"),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
                'x-auth-token': user.token,
              },
              body: jsonEncode({
                "username": user.username,
              }))
          .timeout(const Duration(seconds: 25));

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            print("Notification deletion successful");
          });
    } catch (e) {
      print("Delete Notification Error:$e");
    }
  }
}
