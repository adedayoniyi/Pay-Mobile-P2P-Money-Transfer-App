// ignore_for_file: use_build_context_synchronously, unused_catch_clause, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pay_mobile_app/config/routes/custom_push_navigators.dart';
import 'package:pay_mobile_app/core/error/error_handler.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/core/utils/utils.dart';
import 'package:pay_mobile_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:pay_mobile_app/features/profile/models/message_model.dart';
import 'package:pay_mobile_app/features/profile/providers/chat_provider.dart';
import 'package:pay_mobile_app/features/profile/screens/chat_screen.dart';
import 'package:pay_mobile_app/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_app/widgets/main_app.dart';
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

  void createChat({
    required BuildContext context,
    required String sender,
    required String chatName,
  }) async {
    // final userToken =
    //     Provider.of<UserProvider>(context, listen: false).user.token;
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(Uri.parse("$uri/api/chat"),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
              },
              body: jsonEncode({
                "sender": sender,
                "chatName": chatName,
              }))
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');
      print("Create Chat Status Code ${res.statusCode}");
      print(res.body);
      statusCodeHandler(
        context: context,
        response: res,
        onSuccess: () {
          chatProvider.setChatModel(res.body);
          print("Chat created successfully. ID:  ${chatProvider.chat.id}");
          namedNav(context, ChatScreen.route);
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
      print('Create Chat Error $e');
    }
  }

  void sendMessage({
    required BuildContext context,
    required String sender,
    required String content,
    required String receiver,
  }) async {
    // final userToken =
    //     Provider.of<UserProvider>(context, listen: false).user.token;
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    try {
      http.Response res = await http
          .post(Uri.parse("$uri/message"),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
              },
              body: jsonEncode({
                "sender": sender,
                "receiver": receiver,
                "content": content,
                "chat": chatProvider.chat.id,
              }))
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');
      statusCodeHandler(
        context: context,
        response: res,
        onSuccess: () {
          print("Message Sent Successfully");
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
      print('Send Message Error: $e');
    }
  }

  Future<List<MessageModel>> getAllMessages({
    required BuildContext context,
  }) async {
    List<MessageModel> messageModel = [];
    // final userToken =
    //     Provider.of<UserProvider>(context, listen: false).user.token;
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse("$uri/chat/${chatProvider.chat.id}/messages"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      statusCodeHandler(
        context: context,
        response: res,
        onSuccess: () {
          print("Messages ${res.body}");
          messageModel = (jsonDecode(res.body) as List)
              .map((data) => MessageModel.fromJson(data))
              .toList();
        },
      );
    } on Error catch (e) {
      print('Get Message Error $e');
    }
    return messageModel;
  }
}
