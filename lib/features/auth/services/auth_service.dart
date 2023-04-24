// ignore_for_file: use_build_context_synchronously, avoid_print, unused_catch_clause

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/error_handler.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/utils.dart';
import 'package:money_transfer_app/features/auth/screens/login_screen.dart';
import 'package:money_transfer_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/widgets/main_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String fullname,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        fullname: fullname,
        username: username,
        email: email,
        password: password,
        token: '',
        type: '',
        id: '',
        pin: '',
      );
      showDialogLoader(context);

      http.Response res = await http
          .post(
            Uri.parse("$uri/api/createUser"),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: user.toJson(),
          )
          .timeout(const Duration(seconds: 25));
      Navigator.of(context, rootNavigator: true).pop('dialog');

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            showAlertMessage(
                context: context,
                title: "Success",
                message: "Account created successfully",
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.route);
                });
          });
    } on TimeoutException catch (e) {
      showTimeOutError(
          context: context,
          title: "Time Out",
          message: "Connection time out. Try again",
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
    } on SocketException catch (e) {
      showNoInternetError(
          context: context,
          title: "No Internet",
          message: "Please connect to the internet",
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  Future checkAvailableUsername({
    required BuildContext context,
    required String username,
    required VoidCallback onSuccess,
  }) async {
    String errorText = '';
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/getUsername/$username'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': userToken,
          }).timeout(const Duration(seconds: 25));

      switch (res.statusCode) {
        case 200:
          onSuccess();
          break;
        case 400:
          errorText = jsonDecode(res.body)['message'];
          break;
        case 500:
          showSnackBar(context, jsonDecode(res.body));
      }
    } on TimeoutException catch (e) {
      showTimeOutError(
          context: context,
          title: "Time Out",
          message: "Connection time out. Try again",
          onTap: () {
            Navigator.pop(context);
          });
    } on SocketException catch (e) {
      showNoInternetError(
          context: context,
          title: "No Internet",
          message: "Please connect to the internet",
          onTap: () {
            Navigator.pop(context);
          });
    } on Error catch (e) {
      print('General Error: $e');
    }
    return errorText;
  }

  void loginInUser({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
            Uri.parse('$uri/api/login'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode({
              'username': username,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, MainApp.route, (route) => false,
                arguments: 0);
          });
    } on TimeoutException catch (e) {
      showTimeOutError(
          context: context,
          title: "Time Out",
          message: "Connection time out. Try again",
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
    } on SocketException catch (e) {
      showNoInternetError(
          context: context,
          title: "No Internet",
          message: "Please connect to the internet",
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  Future getUserData({
    required BuildContext context,
  }) async {
    try {
      //showDialogLoader(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': token!
          });
      //the response will supply us with true or false according to the tokenIsValid api
      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //get user data

        http.Response userRes =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': token,
        });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
        //Navigator.of(context, rootNavigator: true).pop('dialog');
      }
      return response;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void createPin({
    required BuildContext context,
    required String pin,
    required String username,
    required String confirmPin,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      if (confirmPin == pin) {
        showDialogLoader(context);
        http.Response res = await http
            .post(
              Uri.parse('$uri/api/createLoginPin/$username'),
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

        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              showAlertMessage(
                  context: context,
                  title: "Success",
                  message: jsonDecode(res.body)['message'],
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, MainApp.route, (route) => false,
                        arguments: 0);
                  });
            });
      } else {
        showErrorMessage(
            context: context,
            title: "Error",
            message: "The pin you entered does not match.Try again",
            onTap: () {
              Navigator.pop(context);
            });
      }
    } on TimeoutException catch (e) {
      showTimeOutError(
          context: context,
          title: "Time Out",
          message: "Connection time out. Try again",
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
    } on SocketException catch (e) {
      showNoInternetError(
          context: context,
          title: "No Internet",
          message: "Please connect to the internet",
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  void loginUsingPin({
    required BuildContext context,
    required String pin,
    required String username,
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

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            Navigator.pushNamedAndRemoveUntil(
                context, MainApp.route, (route) => false,
                arguments: 0);
          });
    } on TimeoutException catch (e) {
      showTimeOutError(
          context: context,
          title: "Time Out",
          message: "Connection time out. Try again",
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
    } on SocketException catch (e) {
      showNoInternetError(
          context: context,
          title: "No Internet",
          message: "Please connect to the internet",
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
    } on Error catch (e) {
      print('General Error: $e');
    }
  }
}
