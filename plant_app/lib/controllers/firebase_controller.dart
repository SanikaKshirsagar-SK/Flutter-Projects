import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import 'database_controller.dart';
import 'profile_controller.dart';

class FirebaseController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
      DatabaseController databaseController = Get.find();


  void successSnackBar() {
    Get.snackbar("Success", "Signed Up Successfully..",
        backgroundColor: const Color.fromRGBO(118, 152, 75, 1),
        snackPosition: SnackPosition.TOP);
  }

  void unsuccessSnackBar() {
    Get.snackbar("Error", "Passwords do not match..",
        backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
  }

  Future<void> signUpWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel obj = UserModel(
        name: name,
        username: email,
        password: password,
      );
      await databaseController.insertUserData(obj);
      successSnackBar();
      Future.delayed(const Duration(seconds: 1), () {
        Get.to(() => const LoginScreen());
      });
    } catch (e) {
      unsuccessSnackBar();
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      List<UserModel> userData = await databaseController.fetchUserData();

      bool flag = false;
      UserModel? loggedInUser;
      for (int i = 0; i < userData.length; i++) {
        if (userData[i].username == email && userData[i].password == password) {
          flag = true;
          loggedInUser = userData[i];
        }
      }
      if (flag) {
        Get.find<ProfileController>().setLoggedInUser(loggedInUser);
        successSnackBar();
        Future.delayed(const Duration(seconds: 1), () {
          Get.to(() => const HomeScreen());
        });
      } else {
        unsuccessSnackBar();
      }
    } catch (e) {
      unsuccessSnackBar();
    }
  }
}
