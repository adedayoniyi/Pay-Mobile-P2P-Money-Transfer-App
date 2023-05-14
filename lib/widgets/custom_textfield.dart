// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';

class CustomTextField extends StatelessWidget {
  String? labelText;
  final String hintText;
  final TextEditingController controller;
  IconButton? icon;
  bool obscureText;
  int maxLines;
  final TextInputType keyboardType;
  CustomTextField({
    Key? key,
    this.labelText = "",
    required this.hintText,
    required this.controller,
    this.icon,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            labelText!,
            style: TextStyle(
              fontSize: heightValue15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          style: TextStyle(fontSize: heightValue20),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 212, 211, 211),
              ),
              borderRadius: BorderRadius.circular(heightValue10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 212, 211, 211),
              ),
              borderRadius: BorderRadius.circular(heightValue10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: defaultAppColor,
              ),
              borderRadius: BorderRadius.circular(heightValue10),
            ),
            hintText: hintText,
            suffixIcon: icon,
          ),
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return hintText;
            }
            return null;
          },
        ),
      ],
    );
  }
}
