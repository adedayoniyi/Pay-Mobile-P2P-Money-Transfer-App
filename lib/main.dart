//ATTENTION!!!!!
/*
1. Please refer to lib/constants/global_constants.dart
2. Refer to lib/widgets to see custom made widgets that were used throughout the app.
3. Refer to lib/router.dart to see the navigation routes for the app
4. Refer to lib/providers/user_provider to see app's state manager for the users data
5. Refer to money_transfer_server to see the nodejs code controlling the backend
*/

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pay_mobile_app/config/routes/custom_push_navigators.dart';
import 'package:pay_mobile_app/config/theme/theme_manager.dart';
import 'package:pay_mobile_app/core/utils/utils.dart';
import 'package:pay_mobile_app/core/utils/custom_notifications.dart';
import 'package:pay_mobile_app/features/auth/screens/login_pin_screen.dart';
import 'package:pay_mobile_app/features/auth/screens/login_screen.dart';
import 'package:pay_mobile_app/features/auth/services/auth_service.dart';
import 'package:pay_mobile_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:pay_mobile_app/features/profile/providers/chat_provider.dart';
import 'package:pay_mobile_app/firebase_options.dart';
import 'package:pay_mobile_app/initialization_screen.dart';
import 'package:pay_mobile_app/no_internet_screen.dart';
import 'package:pay_mobile_app/features/auth/providers/auth_provider.dart';
import 'package:pay_mobile_app/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_app/config/routes/router.dart';
import 'package:pay_mobile_app/widgets/main_app.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static const String route = "/my-app";
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeManager themeManager = ThemeManager();
  final AuthService authService = AuthService();
  final CustomNotifications customNotificatins = CustomNotifications();
  late Future _future;
  bool check = true;

  @override
  void initState() {
    super.initState();
    _future = obtainTokenAndUserData(context);
    checkInternetConnection();
    customNotificatins.requestPermission();
    customNotificatins.initInfo();
    AwesomeNotifications().requestPermissionToSendNotifications();
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
      theme: themeManager.darkTheme,
      darkTheme: themeManager.darkTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => appRoutes(settings),
      home: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return check == true
                ? user.isVerified != false
                    ? user.token.isNotEmpty
                        ? user.pin.isNotEmpty
                            ? const LoginPinScreen()
                            : MainApp(
                                currentPage: 0,
                              )
                        : const OnBoardingScreen()
                    : const LoginScreen()
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
                        popNav(context);
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
