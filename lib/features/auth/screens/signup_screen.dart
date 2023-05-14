import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/features/auth/screens/login_screen.dart';
import 'package:money_transfer_app/features/auth/services/auth_service.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';
import 'package:money_transfer_app/widgets/custom_textfield.dart';
import 'package:money_transfer_app/widgets/username_search_textfield.dart';

class SignUpScreen extends StatefulWidget {
  static const route = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  String? errorText;
  String? successMessage = '';

  final AuthService authService = AuthService();
  final signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    fullnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void createUser() {
    if (signUpFormKey.currentState!.validate()) {
      authService.signUpUser(
        context: context,
        fullname: fullnameController.text,
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  getAvailableUsername() async {
    errorText = await authService.checkAvailableUsername(
        context: context,
        username: usernameController.text,
        onSuccess: () {
          if (usernameController.text.isNotEmpty) {
            setState(() {
              successMessage = "This username is available";
            });
          } else {
            setState(() {
              successMessage = '';
            });
          }
        });
    setState(() {});
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
                            "Signup and start transfering",
                            style: TextStyle(
                              fontSize: heightValue37,
                              fontWeight: FontWeight.w900,
                              height: 1.5,
                            ),
                          ),
                        ),
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
                    buttonText: "Create account",
                    buttonColor: defaultAppColor,
                    buttonTextColor: whiteColor,
                    onTap: () => createUser(),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.route);
                    },
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: heightValue17,
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
      key: signUpFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: UserNameTextField(
                  labelText: "Username",
                  hintText: "username",
                  prefixIcon: "@",
                  controller: usernameController,
                  errorText: errorText == "This username has been taken"
                      ? errorText
                      : null,
                  successMessage: errorText == "This username has been taken"
                      ? ""
                      : successMessage,
                  execute: () {
                    getAvailableUsername();
                  },
                ),
              ),
            ],
          ),
          CustomTextField(
            labelText: "Full Name",
            hintText: "Enter your full name",
            controller: fullnameController,
          ),
          CustomTextField(
            labelText: "Email",
            hintText: "Enter your email address",
            controller: emailController,
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
            height: 150,
          )
        ],
      ),
    );
  }
}
