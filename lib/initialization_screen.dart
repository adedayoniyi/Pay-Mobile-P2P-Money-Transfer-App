import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/widgets/circular_loader.dart';

class InitializationScreen extends StatelessWidget {
  const InitializationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularLoader(),
            SizedBox(
              height: heightValue10,
            ),
            Text(
              "Initializing...",
              style: TextStyle(fontSize: heightValue17),
            ),
            SizedBox(
              height: heightValue10,
            ),
            Text(
              "Please ensure you are connected to the internet",
              style: TextStyle(fontSize: heightValue17),
            )
          ],
        ),
      ),
    );
  }
}
