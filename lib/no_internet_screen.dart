import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onTap;
  const NoInternetScreen({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: value30),
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
                          onTap();
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
  }
}




// Sure, I can show you a possible alternative of the code using `Stream.periodic` instead of `Timer.periodic`. According to the search results²³, you can create a stream that broadcasts events repeatedly at period intervals using the `Stream.periodic` constructor. For example:

// ```dart
// // Create a stream variable
// Stream _myStream;

// // Assign Stream.periodic to the stream variable
// _myStream = Stream.periodic(const Duration(seconds: 5), (count) {
//   // Call getUserBalance() every 5 seconds
//   getUserBalance();
// });
// ```

// To cancel the stream, you need to create a stream subscription and use the `cancel()` method¹². For example:

// ```dart
// // Create a stream subscription variable
// StreamSubscription _sub;

// // Subscribe to the stream events
// _sub = _myStream.listen((event) {
//   // Do something with the event
// });

// // Cancel the stream subscription when needed
// _sub.cancel();
// ```

// To cancel the stream when navigating to another screen, you can use the `dispose()` method of your screen widget. To resume the stream when navigating back, you can use the `initState()` method of your screen widget. For example:

// ```dart
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}): super(key: key);
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // Create a stream variable
//   Stream _myStream;

//   // Create a stream subscription variable
//   StreamSubscription _sub;

//   @override
//   void initState() {
//     super.initState();
//     // Assign Stream.periodic to the stream variable
//     _myStream = Stream.periodic(const Duration(seconds: 5), (count) {
//       // Call getUserBalance() every 5 seconds
//       getUserBalance();
//     });
//     // Subscribe to the stream events
//     _sub = _myStream.listen((event) {
//       // Do something with the event
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Your screen UI here
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // Cancel the stream subscription when the widget is disposed
//     _sub.cancel();
//   }
// }
// ```

// I hope this helps you with your code. If you need more assistance, please let me know.😊

// Source: Conversation with Bing, 21/05/2023
// (1) Flutter Stream.periodic: Tutorial & Example - KindaCode. https://www.kindacode.com/article/flutter-stream-periodic/.
// (2) What is Stream Periodic in Flutter - How to create and cancel Stream .... https://rrtutors.com/tutorials/What-is-Stream-Periodic-in-Flutte-create-and-cancel-Stream-periodic.
// (3) How to cancel a Stream when using Stream.periodic?. https://stackoverflow.com/questions/51583042/how-to-cancel-a-stream-when-using-stream-periodic.
