import 'package:centralogic_assignment/screens/home_screen.dart';
import 'package:centralogic_assignment/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 25),
          child: GestureDetector(
            child: const Text(
              "Skip",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: AppColors.blueColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              "assets/images/first.svg",
              height: 320,
              width: 320,
            ),
            const Text(
              "Your Bookish \nSoulmate Awaits",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                  fontSize: 24),
            ),
            const Text(
              "Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.greyColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 327,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.blueColor),
              child: GestureDetector(
                  child: const Text(
                    "Let's Go",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.whiteColor,
                        fontFamily: "OpenSans"),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductListScreen()));
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
