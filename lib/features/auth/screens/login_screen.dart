import 'package:flutter/material.dart';
import 'package:pay_mobile_app/config/routes/custom_push_navigators.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/features/auth/screens/forgort_password_screen.dart';
import 'package:pay_mobile_app/features/auth/screens/signup_screen.dart';
import 'package:pay_mobile_app/features/auth/screens/signup_verification_screen.dart';
import 'package:pay_mobile_app/features/auth/services/auth_service.dart';
import 'package:pay_mobile_app/features/auth/providers/auth_provider.dart';
import 'package:pay_mobile_app/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_app/widgets/custom_app_bar.dart';
import 'package:pay_mobile_app/widgets/custom_button.dart';
import 'package:pay_mobile_app/widgets/custom_textfield.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';
import 'package:pay_mobile_app/widgets/main_app.dart';
import 'package:provider/provider.dart';

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
        onLoginSuccess: () {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false).user;
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          userProvider.isVerified == true
              ? Navigator.pushNamedAndRemoveUntil(
                  context, MainApp.route, (route) => false,
                  arguments: 0)
              : authService.sendOtp(
                  context: context,
                  email: userProvider.email,
                  sendPurpose: 'sign-up-verification',
                  onTapDialogButton: () => namedNavRemoveUntil(
                    context,
                    SignUpVerificationScreen.route,
                  ),
                );
          authProvider.setUserEmail(userProvider.email);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(image: logo),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HeightSpace(heightValue10),
                      Padding(
                        padding: EdgeInsets.only(right: value20),
                        child: Text(
                          "Login and start transfering",
                          style: TextStyle(
                            fontSize: heightValue35,
                            fontWeight: FontWeight.w900,
                            height: 1.5,
                          ),
                        ),
                      ),
                      formUI()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: value20,
                  right: value20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      buttonText: "Login",
                      buttonColor: primaryAppColor,
                      borderRadius: heightValue30,
                      buttonTextColor: scaffoldBackgroundColor,
                      onTap: () {
                        loginUser();
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.route);
                      },
                      child: Text(
                        "Create new account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: heightValue17),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
            prefixIcon: const Icon(Icons.alternate_email),
            willContainPrefix: true,
            controller: usernameController,
          ),
          CustomTextField(
            obscureText: obscureText,
            labelText: "Password",
            hintText: "Enter your password",
            controller: passwordController,
            icon: InkWell(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          TextButton(
            onPressed: () => namedNav(context, ForgortPasswordScreen.route),
            child: Text(
              "Forgort Password?",
              style: TextStyle(fontSize: heightValue17),
            ),
          )
        ],
      ),
    );
  }
}
