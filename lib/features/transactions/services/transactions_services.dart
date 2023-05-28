// ignore_for_file: use_build_context_synchronously, avoid_print, unused_catch_clause

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/utils.dart';
import 'package:money_transfer_app/models/transactions.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class TransactionServices {
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
      //CircularProgressIndicator();
      http.Response res = await http.get(
        Uri.parse("$uri/api/getTransactions/$username"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userToken,
        },
      ).timeout(const Duration(seconds: 25));
      //Navigator.of(context, rootNavigator: true).pop('dialog');

      switch (res.statusCode) {
        case 200:
          transactions = (json.decode(res.body) as List)
              .map((data) => Transactions.fromJson(data))
              .toList();
          break;
        case 404:
          print("No transactions found!!");
          transactions = [];
          break;
        case 500:
          print("Get Transactions Error");
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
      print('Get All Transactions Error: $e');
    }
    return transactions;
  }
}
