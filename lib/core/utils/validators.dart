import 'package:pay_mobile_app/core/utils/global_constants.dart';

String? validateField(String? value) {
  if (value!.isEmpty) {
    return notEmptyError;
  }
  if (value.length <= 4) {
    return 'Must be more than 4 character';
  } else {
    return null;
  }
}

String? validateName(String? value) {
  if (value!.isEmpty) {
    return notEmptyError;
  }
  if (value.length < 3) {
    return 'Name must be more than 2 character';
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (value!.isEmpty) {
    return notEmptyError;
  }
  if (!regex.hasMatch(value)) {
    return fieldNotValidError;
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  String pattern =
      r'^(?!.*(.)\1\1)(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  RegExp regex = RegExp(pattern);
  if (value!.isEmpty) {
    return notEmptyError;
  }
  if (!regex.hasMatch(value)) {
    return fieldNotValidError;
  } else {
    return null;
  }
}
