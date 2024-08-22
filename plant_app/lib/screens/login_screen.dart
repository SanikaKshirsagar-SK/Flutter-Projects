import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_app/controllers/firebase_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/database_controller.dart';
import '../widget.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DatabaseController controller = DatabaseController();
  @override
  void initState() {
    super.initState();
    DashboardController controller = Get.put(DashboardController());
    controller.tabIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 150, left: 30, right: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Log in",
                  style: textStyleData(
                    fontWeight: FontWeight.w900,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                customTextField(
                  controller: emailController,
                  prefixIcon: Icons.email_outlined,
                  hintText: "Enter your Email-ID",
                  color: Colors.grey,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 40,
                ),
                customTextField(
                  obscureText: true,
                  prefixIcon: Icons.hide_image_outlined,
                  controller: passwordController,
                  hintText: "Enter your password",
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () async {
                  if (_formKey.currentState!.validate()) {
                  FirebaseController controller = Get.find();
                  await controller.signInWithEmailAndPassword(
                    emailController.text,
                    passwordController.text,
                  );
                }
                },
                  child: buttonStyle(buttonText: "Login", context: context),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User? Click Here To Register ",
                      style: textStyleData1(12, 400, 18, [0, 0, 0, 1]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignUpScreen());
                      },
                      child: Text(
                        "Sign Up",
                        style: textStyleData1(12, 900, 18, [0, 0, 0, 1]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Image.asset(
                  "assets/2.png",
                  height: 359,
                  width: 359,
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
        ));
  }
}
