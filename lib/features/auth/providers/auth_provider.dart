import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? deviceToken;
  String? emailAddress;

  void setDeviceToken(String? token) {
    deviceToken = token;
    notifyListeners();
  }

  void setUserEmail(String? email) {
    emailAddress = email;
    notifyListeners();
  }
}
