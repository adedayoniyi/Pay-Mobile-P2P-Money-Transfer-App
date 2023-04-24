//ATTENTION!!!!!
/*
1. Please refer to lib/constants/global_constants.dart
2. Refer to lib/widgets to see custom made widgets that were used throughout the app.
3. Refer to lib/router.dart to see the navigation routes for the app
4. Refer to lib/providers/user_provider to see app's state manager for the users data
5. Refer to money_transfer_server to see the nodejs code controlling the backend
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/utils.dart';
import 'package:money_transfer_app/features/auth/screens/login_pin_screen.dart';
import 'package:money_transfer_app/features/auth/services/auth_service.dart';
import 'package:money_transfer_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/router.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';
import 'package:money_transfer_app/widgets/main_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  static const String route = "/my-app";
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  late Future _future;
  bool check = true;

  @override
  void initState() {
    super.initState();
    _future = getUserData(context);
    checkInternetConnection();
  }

  getUserData(BuildContext context) async {
    await authService.getUserData(context: context);
  }

  checkInternetConnection() async {
    check = await InternetConnectionChecker().hasConnection;
    return check;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final user = Provider.of<UserProvider>(context).user;
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "SF Pro",
        scaffoldBackgroundColor: whiteColor,
        colorScheme: const ColorScheme.light(
          primary: defaultAppColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => appRoutes(settings),
      home: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return check == true
                ? user.token.isNotEmpty
                    ? user.pin.isNotEmpty
                        ? const LoginPinScreen()
                        : MainApp(
                            currentPage: 0,
                          )
                    : const OnBoardingScreen()
                : Scaffold(
                    body: SafeArea(
                      child: Stack(
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: value30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/no-internet.png",
                                    height: heightValue150,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    height: heightValue20,
                                  ),
                                  const Text("Please connect to the internet"),
                                  SizedBox(
                                    height: heightValue50,
                                  ),
                                  CustomButton(
                                      buttonText: "Try Again",
                                      buttonColor: defaultAppColor,
                                      buttonTextColor: whiteColor,
                                      onTap: () {
                                        checkInternetConnection();
                                        getUserData(context);
                                        if (check == true) {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            MyApp.route,
                                            (route) => false,
                                          );
                                        } else {
                                          showDialogLoader(context);
                                          Future.delayed(
                                              const Duration(seconds: 5), () {
                                            Navigator.of(context).pop();
                                          });
                                        }
                                      })
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: heightValue30),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/full_logo.png",
                                    height: value100,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          } else {}

          return Scaffold(
            backgroundColor: scaffoldBackgroundColor,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator(
                      color: defaultAppColor,
                    ),
                  ),
                  SizedBox(
                    height: heightValue10,
                  ),
                  const Text("Initializing..."),
                  SizedBox(
                    height: heightValue10,
                  ),
                  const Text("Please ensure you are connected to the internet")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
