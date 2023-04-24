import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';

class CommingSoonScreen extends StatelessWidget {
  static const String route = "/comming-soon-screen";
  const CommingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: value30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: heightValue30,
                ),
                Image.asset(
                  "assets/images/full_logo.png",
                  height: value145,
                ),
                SizedBox(
                  height: heightValue20,
                ),
                Text(
                  "Comming Soon",
                  style: TextStyle(
                    fontSize: value25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: heightValue20,
                ),
                Image.asset("assets/images/empty_list.png"),
                SizedBox(
                  height: heightValue20,
                ),
                Text(
                  "This feature is Comming Soon. Stay tuned",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: value25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
