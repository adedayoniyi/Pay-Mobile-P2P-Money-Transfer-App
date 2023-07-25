import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/core/utils/validators.dart';
import 'package:pay_mobile_app/features/auth/services/auth_service.dart';
import 'package:pay_mobile_app/widgets/custom_app_bar.dart';
import 'package:pay_mobile_app/widgets/custom_textfield.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  static const String route = "/create-new-password";
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final createNewPasswordFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(image: logo),
      body: screenUI(),
    );
  }

  void createNewPassword() {
    if (createNewPasswordFormKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        authService.createNewPassword(
          context: context,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        );
      }
    }
  }

  Widget screenUI() {
    return Form(
      key: createNewPasswordFormKey,
      child: Column(
        children: [
          HeightSpace(heightValue10),
          const Text("Create New Password"),
          CustomTextField(
            hintText: "Enter your password",
            controller: passwordController,
            labelText: "Password",
            validator: validateField,
          ),
          CustomTextField(
            hintText: "Enter your password",
            controller: confirmPasswordController,
            labelText: "ConfirmPassword",
            validator: validateField,
          ),
        ],
      ),
    );
  }
}
