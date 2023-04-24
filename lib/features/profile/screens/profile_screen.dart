import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/textstyle_constants.dart';
import 'package:money_transfer_app/features/profile/screens/change_pin_screen.dart';
import 'package:money_transfer_app/features/profile/services/profile_services.dart';
import 'package:money_transfer_app/features/profile/widgets/profile_card.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileServices profileServices = ProfileServices();

  void logOut() {
    profileServices.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: value20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: value40,
              child: Center(
                child: Text(
                  user.fullname[0],
                  style: TextStyle(fontSize: value25),
                ),
              ),
            ),
            SizedBox(
              height: heightValue20,
            ),
            Text(
              user.fullname,
              style: heading5GreyScale900,
            ),
            Text(
              user.email,
              style: textRegularMedium,
            ),
            Text(
              "@${user.username}",
              style: textRegularMedium,
            ),
            SizedBox(
              height: heightValue20,
            ),
            ProfileCard(
              iconImage: "assets/icons/profile_icon.png",
              profileOperation: "Edit Profile",
              profileOperationDescription: "Personal info, name, etc",
              onPressed: () {},
            ),
            SizedBox(
              height: heightValue20,
            ),
            ProfileCard(
              iconImage: "assets/icons/profile_icon.png",
              profileOperation: "Security",
              profileOperationDescription: "Passwords, Change pin, etc",
              onPressed: () {
                Navigator.pushNamed(context, ChangeLoginPinScreen.route);
              },
            ),
            SizedBox(
              height: heightValue20,
            ),
            ProfileCard(
              iconImage: "assets/icons/logout_icon.png",
              profileOperation: "Sign Out",
              profileOperationDescription: "Sign out of your account",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: whiteColor,
                          surfaceTintColor: whiteColor,
                          icon: Image.asset(
                            "assets/icons/info-circle.png",
                            height: value100,
                            width: value100,
                          ),
                          title: Text("Caution",
                              style: TextStyle(
                                  fontSize: value18,
                                  fontWeight: FontWeight.bold)),
                          content: Text(
                            "Are you sure you want to logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[600]),
                          ),
                          actions: <Widget>[
                            CustomButton(
                              buttonText: "Yes",
                              onTap: () {
                                logOut();
                              },
                              buttonColor: defaultAppColor,
                              buttonTextColor: whiteColor,
                            ),
                            SizedBox(
                              height: heightValue10,
                            ),
                            CustomButton(
                              buttonText: "Cancel",
                              onTap: () {
                                Navigator.pop(context);
                              },
                              buttonColor: defaultAppColor,
                              buttonTextColor: whiteColor,
                            )
                          ],
                        ));
              },
            ),
          ],
        ),
      )),
    );
  }
}
