import "package:flutter/material.dart";
import "package:get/get.dart";
import "../Models/user_model.dart";
import "../Views/home_screen.dart";
import "../Controllers/database_controller.dart";
import "../Controllers/profile_controller.dart";
import "../widgets.dart";
import "sign_up_screen.dart";

class SignInScreen extends GetView<DatabaseController> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInScreen({super.key});

  void successSnackBar() {
    Get.snackbar("Success", "Logged In Successfully..",
        backgroundColor: Colors.green, snackPosition: SnackPosition.TOP);
    Future.delayed(const Duration(seconds: 1), () {
      Get.to(() => const HomeScreen());
    });
  }

  void unsuccessSnackBar() {
    Get.snackbar("Error", "Invalid Username or Password..",
        backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
  }

  void _submitButton() async {
    if (_formKey.currentState!.validate()) {
      List<UserModel> userData = await controller.fetchUserData();

      bool flag = false;
      UserModel? loggedInUser;
      for (int i = 0; i < userData.length; i++) {
        if (userData[i].username == _usernameController.text.trim() &&
            userData[i].password == _passwordController.text) {
          flag = true;
          loggedInUser = userData[i];
        }
      }
      if (flag) {
        Get.find<ProfileController>().setLoggedInUser(loggedInUser);
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
          title: "Sign In",
          textColor: Colors.white,
          backgroundColor: const Color.fromRGBO(76, 61, 59, 1)),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome Back!",
                      style: textStyleHeadingData(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(height: 30),
                    customTextField("Username",
                        controller: _usernameController),
                    const SizedBox(height: 30),
                    customTextField("Password",
                        controller: _passwordController),
                    const SizedBox(
                      height: 30,
                    ),
                    customButton(
                        onPressed: () {
                          _submitButton();
                        },
                        buttonText: "Sign In"),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New User? Click Here To Register ",
                          style: textStyleData(12, 400, 18, [0, 0, 0, 1]),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SignUpScreen());
                          },
                          child: Text(
                            "Sign Up",
                            style: textStyleData(12, 900, 18, [0, 0, 0, 1]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
