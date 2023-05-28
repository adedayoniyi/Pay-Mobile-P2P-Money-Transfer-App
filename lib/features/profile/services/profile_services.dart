// ignore_for_file: use_build_context_synchronously, unused_catch_clause, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/constants/error_handler.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/utils.dart';
import 'package:money_transfer_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/widgets/main_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileServices {
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        OnBoardingScreen.route,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void changeLoginPin({
    required BuildContext context,
    required String username,
    required String oldPin,
    required String newPin,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(Uri.parse("$uri/api/changePin/$username"),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
                'x-auth-token': userToken,
              },
              body: jsonEncode({
                "oldPin": oldPin,
                "newPin": newPin,
              }))
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');
      statusCodeHandler(
        context: context,
        response: res,
        onSuccess: () {
          showAlertMessage(
              context: context,
              title: "Successful",
              message: jsonDecode(res.body)["message"],
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MainApp.route,
                  (route) => false,
                  arguments: 2,
                );
              });
        },
      );
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
      print('Change Pin Error Error: $e');
    }
  }
}
