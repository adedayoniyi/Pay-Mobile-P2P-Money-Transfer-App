//THis the the bottom navigation bar for the entire appplication
import 'package:flutter/material.dart';

import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/features/home/screens/home_screen.dart';
import 'package:pay_mobile_app/features/profile/screens/profile_screen.dart';
import 'package:pay_mobile_app/features/transactions/screens/all_transactions_screen.dart';

class MainApp extends StatefulWidget {
  static const String route = '/main-app';
  int currentPage;
  MainApp({
    Key? key,
    this.currentPage = 0,
  }) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  PageController pageController = PageController();
  void updatePage(int page) {
    setState(() {
      widget.currentPage = page;
    });
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBody: true,
        backgroundColor: Colors.transparent,
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              widget.currentPage = page;
            });
          },
          children: const [
            HomeScreen(),
            TransactionsScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: primaryAppColor,
          elevation: 0,
          //fixedColor: primaryAppColor,
          type: BottomNavigationBarType.fixed,
          onTap: updatePage,
          currentIndex: widget.currentPage,
          selectedItemColor: secondaryAppColor,
          unselectedItemColor: greyScale600,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            color: secondaryAppColor,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                homeIcon,
                height: heightValue40,
                color:
                    widget.currentPage == 0 ? secondaryAppColor : greyScale600,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Image.asset(
                  transactionsIcon,
                  height: heightValue45,
                  color: widget.currentPage == 1
                      ? secondaryAppColor
                      : greyScale600,
                ),
                label: "Transactions"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  profileIcon,
                  height: heightValue40,
                  color: widget.currentPage == 2
                      ? secondaryAppColor
                      : greyScale600,
                ),
                label: "Profile"),
          ],
        ));
  }
}
