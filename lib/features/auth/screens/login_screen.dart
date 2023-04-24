import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/features/auth/screens/signup_screen.dart';
import 'package:money_transfer_app/features/auth/services/auth_service.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';
import 'package:money_transfer_app/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool obscureText = true;
  final loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void loginUser() {
    if (loginFormKey.currentState!.validate()) {
      authService.loginInUser(
        context: context,
        username: usernameController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: value20),
                          child: Text(
                            "Login and start transfering",
                            style: TextStyle(
                              fontSize: value35,
                              fontWeight: FontWeight.w900,
                              height: 1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 260, top: 30),
                          child: Image.asset(
                            'assets/images/send_icon.png',
                            color: defaultAppColor,
                            height: 65,
                          ),
                        )
                      ],
                    ),
                    formUI()
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    buttonText: "Login",
                    buttonColor: defaultAppColor,
                    buttonTextColor: whiteColor,
                    onTap: () {
                      loginUser();
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.route);
                    },
                    child: const Text(
                      "Create new account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formUI() {
    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          CustomTextField(
            labelText: "Username",
            hintText: "Enter your unique username",
            controller: usernameController,
          ),
          CustomTextField(
            obscureText: obscureText,
            labelText: "Password",
            hintText: "Enter your password",
            controller: passwordController,
            icon: obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = false;
                      });
                    },
                    icon: const Icon(
                      Icons.visibility_off,
                    ))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = true;
                      });
                    },
                    icon: const Icon(
                      Icons.visibility,
                    )),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
