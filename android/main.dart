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
import 'package:money_transfer_app/initialization_screen.dart';
import 'package:money_transfer_app/no_internet_screen.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/router.dart';
import 'package:money_transfer_app/widgets/main_app.dart';
import 'package:provider/provider.dart';

void main() async {
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
    _future = obtainTokenAndUserData(context);
    checkInternetConnection();
  }

  obtainTokenAndUserData(BuildContext context) async {
    await authService.obtainTokenAndUserData(context);
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
                : NoInternetScreen(onTap: () {
                    checkInternetConnection();
                    obtainTokenAndUserData(context);
                    if (check == true) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MyApp.route,
                        (route) => false,
                      );
                    } else {
                      showDialogLoader(context);
                      Future.delayed(const Duration(seconds: 5), () {
                        Navigator.of(context).pop();
                      });
                    }
                  });
          } else {}

          return const InitializationScreen();
        },
      ),
    );
  }
}
