import 'package:flutter/material.dart';
import 'package:pay_mobile_app/config/routes/custom_push_navigators.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/core/utils/validators.dart';
import 'package:pay_mobile_app/features/auth/screens/login_screen.dart';
import 'package:pay_mobile_app/features/auth/screens/signup_verification_screen.dart';
import 'package:pay_mobile_app/features/auth/services/auth_service.dart';
import 'package:pay_mobile_app/features/auth/providers/auth_provider.dart';
import 'package:pay_mobile_app/widgets/custom_app_bar.dart';
import 'package:pay_mobile_app/widgets/custom_button.dart';
import 'package:pay_mobile_app/widgets/custom_textfield.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscureText = true;
  bool obscureText2 = true;

  String? errorText;
  String? successMessage = '';
  String misMatchPasswordErrorText = '';

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

  void createUser() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (signUpFormKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        authService.signUpUser(
          context: context,
          fullname: fullnameController.text,
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          onSignUpSuccess: () async {
            print("Sign Up Success");
            authService.sendOtp(
              context: context,
              email: emailController.text,
              sendPurpose: 'sign-up-verification',
              onTapDialogButton: () => namedNav(
                context,
                SignUpVerificationScreen.route,
              ),
            );
            authProvider.setUserEmail(emailController.text);
          },
        );
      } else {
        setState(() {
          misMatchPasswordErrorText = "Passwords Do not Match";
        });
      }
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(image: logo),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: value20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HeightSpace(heightValue10),
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
                      buttonText: "Create account",
                      buttonColor: primaryAppColor,
                      buttonTextColor: scaffoldBackgroundColor,
                      borderRadius: heightValue30,
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
                child: CustomTextField(
                  willContainPrefix: true,
                  labelText: "Username",
                  hintText: "Username",
                  prefixIcon: const Icon(Icons.alternate_email),
                  controller: usernameController,
                  errorText: errorText == "This username has been taken"
                      ? errorText
                      : null,
                  successMessage: errorText == "This username has been taken"
                      ? ""
                      : successMessage,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      getAvailableUsername();
                    }
                  },
                ),
              ),
            ],
          ),
          CustomTextField(
            labelText: "Full Name",
            hintText: "Enter your full name",
            controller: fullnameController,
            validator: validateName,
          ),
          CustomTextField(
            labelText: "Email",
            hintText: "Enter your email address",
            controller: emailController,
            validator: validateEmail,
          ),
          CustomTextField(
            obscureText: obscureText,
            labelText: "Password",
            hintText: "Enter your password",
            controller: passwordController,
            errorText: misMatchPasswordErrorText.isNotEmpty
                ? misMatchPasswordErrorText
                : null,
            icon: GestureDetector(
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
          CustomTextField(
            errorText: misMatchPasswordErrorText.isNotEmpty
                ? misMatchPasswordErrorText
                : null,
            obscureText: obscureText2,
            labelText: "Confirm Password",
            hintText: "Enter your password",
            controller: confirmPasswordController,
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  obscureText2 = !obscureText2;
                });
              },
              child: Icon(
                obscureText2 ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          const SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}
