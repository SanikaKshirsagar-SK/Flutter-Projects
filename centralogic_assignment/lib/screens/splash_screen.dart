
import 'package:centralogic_assignment/screens/first_screen.dart';
import 'package:centralogic_assignment/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(74, 138, 196, 1),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/logo.svg"),
                const SizedBox(width: 20,),
                const Text("BOOK HEAVEN", style: TextStyle(
                  color:  AppColors.whiteColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 31.55,
                  fontFamily: "Roboto"
                ))
              ],
            ),
          )),
    );
  }
}
