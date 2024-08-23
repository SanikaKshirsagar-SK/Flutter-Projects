import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_app/controllers/firebase_controller.dart';
import '../screens/login_screen.dart';
import '../controllers/database_controller.dart';
import '../widget.dart';

class SignUpScreen extends GetView<DatabaseController> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final FirebaseController firebaseController = Get.find();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: customAppBar1(
            title: "Sign Up",
            textColor: const Color.fromRGBO(255, 255, 255, 1),
            backgroundColor: const Color.fromARGB(255, 99, 137, 50)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customTextField1("Name", controller: nameController),
                const SizedBox(height: 30),
                customTextField1(
                  "Username",
                  controller: emailController,
                ),
                const SizedBox(height: 30),
                customTextField1("Password",
                    controller: passwordController, obscureText: true),
                const SizedBox(height: 30),
                customTextField1("Confirm Password",
                    controller: confirmPasswordController, obscureText: true),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          await firebaseController.signUpWithEmailAndPassword(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                        } else {
                          firebaseController.unsuccessSnackBar();
                        }
                      }
                    },
                    child: buttonStyle(
                        buttonText: "Sign Up",
                        textColor: const Color.fromRGBO(255, 255, 255, 1),
                        context: context)),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: textStyleData1(14, 400, 18, [0, 0, 0, 0.6]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginScreen());
                      },
                      child: Text(
                        "Sign In",
                        style: textStyleData1(14, 900, 18, [13, 13, 14, 1]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Image.asset(
                  "assets/6.jpg",
                  height: 359,
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
        ));
  }
}
