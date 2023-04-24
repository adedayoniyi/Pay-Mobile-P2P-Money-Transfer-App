import 'package:flutter/material.dart';
import 'package:money_transfer_app/features/auth/screens/login_screen.dart';
import 'package:money_transfer_app/features/auth/screens/signup_screen.dart';
import 'package:money_transfer_app/features/home/screens/comming_soon_screen.dart';
import 'package:money_transfer_app/features/home/screens/fund_wallet_screen.dart';
import 'package:money_transfer_app/features/home/screens/home_screen.dart';
import 'package:money_transfer_app/features/home/screens/send_money_screen.dart';
import 'package:money_transfer_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:money_transfer_app/features/profile/screens/change_pin_screen.dart';
import 'package:money_transfer_app/features/transactions/screens/transactions_screen.dart';
import 'package:money_transfer_app/main.dart';
import 'package:money_transfer_app/widgets/main_app.dart';

Route<dynamic> appRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.route:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        settings: routeSettings,
      );
    case SignUpScreen.route:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SignUpScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        settings: routeSettings,
      );
    case MainApp.route:
      var currentPage = routeSettings.arguments as int;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => MainApp(currentPage: currentPage),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        settings: routeSettings,
      );
    case SendMoneyScreen.route:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SendMoneyScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position:
              Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                  .animate(animation),
          child: child,
        ),
        settings: routeSettings,
      );
    case HomeScreen.route:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        settings: routeSettings,
      );
    case OnBoardingScreen.route:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const OnBoardingScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        settings: routeSettings,
      );
    case TransactionsScreen.route:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const TransactionsScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        settings: routeSettings,
      );
    case CommingSoonScreen.route:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const CommingSoonScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position:
              Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                  .animate(animation),
          child: child,
        ),
        settings: routeSettings,
      );
    case ChangeLoginPinScreen.route:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const ChangeLoginPinScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position:
              Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                  .animate(animation),
          child: child,
        ),
        settings: routeSettings,
      );
    case MyApp.route:
      return MaterialPageRoute(
        builder: (context) => const MyApp(),
      );
    case FundWalletScreen.route:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const FundWalletScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position:
              Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                  .animate(animation),
          child: child,
        ),
        settings: routeSettings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("This page dosent exist"),
          ),
        ),
      );
  }
}
