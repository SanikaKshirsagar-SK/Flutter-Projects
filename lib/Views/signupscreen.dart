import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/databasecontroller.dart';
import '../Models/usermodel.dart';
import '../widgets.dart';
import 'signinscreen.dart';

class SignUpScreen extends GetView<DatabaseController> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  SignUpScreen({super.key});

  void successSnackBar() {
    Get.snackbar("Success", "Signed Up Successfully..",
        backgroundColor: Colors.green, snackPosition: SnackPosition.TOP);
    Future.delayed(const Duration(seconds: 1), () {
      Get.to(() => SignInScreen());
    });
  }

  void unsuccessSnackBar() {
    Get.snackbar("Error", "Passwords do not match..",
        backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
  }

  void submitButton() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        UserModel obj = UserModel(
            name: nameController.text,
            username: usernameController.text,
            password: passwordController.text);
        await controller.insertUserData(obj);
        successSnackBar();
      } else {
        unsuccessSnackBar();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: customAppBar(
            title: "Sign Up",
            backgroundColor: const Color.fromRGBO(255, 122, 0, 1)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customTextField("Name", controller: nameController),
                const SizedBox(height: 30),
                customTextField("Username", controller: usernameController),
                const SizedBox(height: 30),
                customTextField("Password", controller: passwordController),
                const SizedBox(height: 30),
                customTextField("Confirm Password",
                    controller: confirmPasswordController),
                const SizedBox(
                  height: 30,
                ),
                customButton(
                    onPressed: () {
                      submitButton();
                    },
                    buttonText: "Sign Up"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: textStyleData(12, 400, 18, [0, 0, 0, 0.6]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignInScreen());
                      },
                      child: Text(
                        "Sign In",
                        style: textStyleData(12, 900, 18, [0, 0, 0, 0.6]),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
