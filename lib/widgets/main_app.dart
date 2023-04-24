// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:money_transfer_app/constants/color_constants.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/features/home/screens/home_screen.dart';
import 'package:money_transfer_app/features/profile/screens/profile_screen.dart';
import 'package:money_transfer_app/features/transactions/screens/transactions_screen.dart';

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
      extendBody: true,
      //backgroundColor: Colors.transparent,
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: heightValue30,
          left: value20,
          right: value20,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(value25),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: widget.currentPage,
            selectedItemColor: Colors.white,
            unselectedItemColor: greyScale500,
            backgroundColor: defaultAppColor,
            iconSize: value30,
            onTap: updatePage,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: value15),
                  child: Image.asset(
                    "assets/icons/home_icon.png",
                    height: value30,
                    color: widget.currentPage == 0 ? whiteColor : greyScale600,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: value15),
                  child: Image.asset(
                    "assets/icons/transactions_icon.png",
                    height: value35,
                    color: widget.currentPage == 1 ? whiteColor : greyScale600,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: value15),
                  child: Image.asset(
                    "assets/icons/profile_icon.png",
                    height: value30,
                    color: widget.currentPage == 2 ? whiteColor : greyScale600,
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
