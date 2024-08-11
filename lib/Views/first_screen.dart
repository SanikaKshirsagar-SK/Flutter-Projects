import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets.dart';
import 'signinscreen.dart';
import 'signupscreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              child: Image.asset(
                "assets/1.png",
                height: 550,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Find The",
                      style: textStyleData(42, 600, 50, [13, 13, 13, 1])),
                  Text("Best Collections",
                      style: textStyleData(42, 600, 50, [13, 13, 13, 1])),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Get your dream item easily with FashionHub and get other interesting offers",
                      style: textStyleData(15, 400, 24, [121, 119, 128, 1])),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customButtonRounded(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          onPressed: () {
                            Get.to(() => SignUpScreen());
                          },
                          buttonText: "Sign Up",
                          textColor: [13, 13, 14, 1]),
                      customButtonRounded(
                          onPressed: () {
                            Get.to(() => SignInScreen());
                          },
                          buttonText: "Sign In")
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
