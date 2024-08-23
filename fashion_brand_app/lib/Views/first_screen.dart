import "package:flutter/material.dart";
import "package:get/get.dart";
import "../widgets.dart";
import "sign_in_screen.dart";
import "sign_up_screen.dart";

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(120)),
              child: Image.asset(
                "assets/1.png",
                // height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Fashion,\nForward.",
                    style: textStyleData(42, 600, 50, [13, 13, 13, 1])),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    "Look good, feel good, shop good Elevate your style, elevate your mood Shop with us, feel the difference...",
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
    );
  }
}
