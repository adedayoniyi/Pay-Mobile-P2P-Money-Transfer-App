import 'package:flutter/material.dart';
import 'package:pay_mobile_app/core/utils/color_constants.dart';
import 'package:pay_mobile_app/core/utils/global_constants.dart';
import 'package:pay_mobile_app/core/utils/assets.dart';
import 'package:pay_mobile_app/features/home/screens/comming_soon_screen.dart';
import 'package:pay_mobile_app/features/profile/screens/change_pin_screen.dart';
import 'package:pay_mobile_app/features/profile/services/profile_services.dart';
import 'package:pay_mobile_app/features/profile/widgets/profile_card.dart';
import 'package:pay_mobile_app/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_app/widgets/custom_button.dart';
import 'package:pay_mobile_app/widgets/height_space.dart';
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

  void createChat() {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    print(userProvider.username);
    profileServices.createChat(
      context: context,
      sender: userProvider.username,
      chatName: "Pay Mobile Support",
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      // backgroundColor: scaffoldBackgroundColor,
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
              style: TextStyle(
                fontSize: heightValue25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user.email,
              style: TextStyle(
                fontSize: heightValue18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "@${user.username}",
              style: TextStyle(
                fontSize: heightValue20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: heightValue20,
            ),
            ProfileCard(
              iconImage: "assets/icons/profile_icon.png",
              profileOperation: "Edit Profile",
              profileOperationDescription: "Personal info, name, etc",
              onPressed: () {
                Navigator.pushNamed(context, CommingSoonScreen.route);
              },
            ),
            SizedBox(
              height: heightValue20,
            ),
            ProfileCard(
              iconImage: "assets/icons/settings_icon.png",
              profileOperation: "Security",
              profileOperationDescription: "Change Password, Pin",
              onPressed: () {
                Navigator.pushNamed(context, ChangeLoginPinScreen.route);
              },
            ),
            SizedBox(
              height: heightValue20,
            ),
            ProfileCard(
              iconImage: chatIcon,
              profileOperation: "Contact Us",
              profileOperationDescription: "Have a problem? Get in touch",
              onPressed: () {
                createChat();
                //namedNav(context, ChatScreen.route);
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
                          backgroundColor: greyScale850,
                          surfaceTintColor: greyScale850,
                          icon: Image.asset(
                            infoCircle,
                            height: value100,
                            width: value100,
                            color: whiteColor,
                          ),
                          title: Text("Caution",
                              style: TextStyle(
                                fontSize: value18,
                                fontWeight: FontWeight.bold,
                              )),
                          content: Text(
                            "Are you sure you want to logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: heightValue15,
                              color: Colors.grey[600],
                            ),
                          ),
                          actions: <Widget>[
                            CustomButton(
                              buttonText: "Yes",
                              onTap: () {
                                logOut();
                              },
                              buttonColor: primaryAppColor,
                              buttonTextColor: secondaryAppColor,
                            ),
                            HeightSpace(heightValue10),
                            CustomButton(
                              buttonText: "Cancel",
                              onTap: () {
                                Navigator.pop(context);
                              },
                              buttonColor: primaryAppColor,
                              buttonTextColor: secondaryAppColor,
                            )
                          ],
                        ));
              },
            ),
            HeightSpace(heightValue20),
            Text(
              "Version 2.0.0",
              style: TextStyle(
                fontSize: heightValue20,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
