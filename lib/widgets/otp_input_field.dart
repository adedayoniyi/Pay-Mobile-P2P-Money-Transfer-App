import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';

class OtpCodeInputField extends StatefulWidget {
  final TextEditingController controller;
  final Color fillColor;
  const OtpCodeInputField({
    Key? key,
    required this.controller,
    this.fillColor = greyScale850,
  }) : super(key: key);

  @override
  State<OtpCodeInputField> createState() => _OtpCodeInputFieldState();
}

class _OtpCodeInputFieldState extends State<OtpCodeInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(fontSize: heightValue25),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.fillColor,
          ),
          borderRadius: BorderRadius.circular(heightValue10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.fillColor,
          ),
          borderRadius: BorderRadius.circular(heightValue10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: primaryAppColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(heightValue10),
        ),
        isDense: true,
        counterText: '',
        contentPadding: EdgeInsets.all(heightValue10),
        filled: true,
        fillColor: widget.fillColor,
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return notEmptyError;
        }
        return null;
      },
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
        if (value.isEmpty) {
          FocusScope.of(context).previousFocus();
        }
      },
      autofocus: true,
      showCursor: false,
      textAlign: TextAlign.center,
      maxLength: 1,
    );
  }
}
