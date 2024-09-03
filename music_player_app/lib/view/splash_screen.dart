import 'package:flutter/material.dart';
import 'package:music_player_app/widgets/style_widget.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            "assets/first.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 50,
            child: Column(
              children: [
                SizedBox(
                  // height: 140,
                  width: 380,
                  child: Text(
                    "Dancing between \nThe shadows \nOf rhythm",
                    style: customTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 36,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(255, 46, 0, 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(19)))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                      },
                      child: Text(
                        "Get Started",
                        style: customTextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            color: const Color.fromRGBO(19, 19, 19, 1)),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
