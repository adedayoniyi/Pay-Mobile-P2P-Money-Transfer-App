import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/constants/textstyle_constants.dart';
import 'package:money_transfer_app/features/home/screens/comming_soon_screen.dart';
import 'package:money_transfer_app/features/home/screens/fund_wallet_screen.dart';
import 'package:money_transfer_app/features/home/screens/send_money_screen.dart';
import 'package:money_transfer_app/widgets/payment_containers.dart';

class PaymentOptionsColumn extends StatelessWidget {
  const PaymentOptionsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: value90,
              child: Column(
                children: [
                  PaymentContainers(
                    icon: "assets/icons/add_icon.png",
                    color: const Color(0xFFDFAD2C),
                    onTap: () {
                      Navigator.pushNamed(context, FundWalletScreen.route);
                    },
                  ),
                  Text(
                    "Fund",
                    style: textRegularMedium,
                  )
                ],
              ),
            ),
            SizedBox(
              width: value90,
              child: Column(
                children: [
                  PaymentContainers(
                    icon: "assets/icons/send_icon.png",
                    color: const Color(0xFFA9224A),
                    onTap: () {
                      Navigator.pushNamed(context, SendMoneyScreen.route);
                    },
                  ),
                  Text(
                    "Transfer",
                    style: textRegularMedium,
                  )
                ],
              ),
            ),
            SizedBox(
              width: value90,
              child: Column(
                children: [
                  PaymentContainers(
                    icon: "assets/icons/mobile_icon.png",
                    color: const Color(0xFF2248A9),
                    onTap: () {
                      Navigator.pushNamed(context, CommingSoonScreen.route);
                    },
                  ),
                  Text(
                    "Airtime",
                    style: textRegularMedium,
                  )
                ],
              ),
            ),
            SizedBox(
              width: value90,
              child: Column(
                children: [
                  PaymentContainers(
                    icon: "assets/icons/vouchour_icon.png",
                    color: const Color(0xFF0F975E),
                    onTap: () {
                      Navigator.pushNamed(context, CommingSoonScreen.route);
                    },
                  ),
                  Text(
                    "Voucher",
                    style: textRegularMedium,
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: heightValue15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: value90,
              child: Column(
                children: [
                  PaymentContainers(
                    icon: "assets/icons/add_icon.png",
                    color: const Color(0xFF871482),
                    onTap: () {
                      Navigator.pushNamed(context, CommingSoonScreen.route);
                    },
                  ),
                  Text(
                    "Electricity",
                    style: textRegularMedium,
                  )
                ],
              ),
            ),
            SizedBox(
              width: value90,
              child: Column(
                children: [
                  PaymentContainers(
                    icon: "assets/icons/wifi_icon.png",
                    color: const Color(0xFF5337A5),
                    onTap: () {
                      Navigator.pushNamed(context, CommingSoonScreen.route);
                    },
                  ),
                  Text(
                    "Internet",
                    style: textRegularMedium,
                  )
                ],
              ),
            ),
            SizedBox(
              width: value90,
              child: Column(
                children: [
                  PaymentContainers(
                    icon: "assets/icons/bills_icon.png",
                    color: const Color(0xFFDF6C2C),
                    onTap: () {
                      Navigator.pushNamed(context, CommingSoonScreen.route);
                    },
                  ),
                  Text(
                    "Bills",
                    style: textRegularMedium,
                  )
                ],
              ),
            ),
            SizedBox(
              width: value90,
              child: Column(
                children: [
                  PaymentContainers(
                    icon: "assets/icons/more_icon.png",
                    color: const Color(0xFF13A958),
                    onTap: () {
                      Navigator.pushNamed(context, CommingSoonScreen.route);
                    },
                  ),
                  Text(
                    "More",
                    style: textRegularMedium,
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
