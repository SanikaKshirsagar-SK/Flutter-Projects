import 'dart:developer';

import 'package:flutter/material.dart';
import '../Models/principal_model.dart';

// Provider for PrincipalLoginController class
class PrincipalLoginController with ChangeNotifier {
  late PrincipalModel _principal;

  PrincipalLoginController() {

    // Principal Object
    _principal = PrincipalModel(
      principalId: 0,
      principalEmailId: '',
      principalPassword: '',
    );
  }

  // Principal getter
  PrincipalModel get principal => _principal;

  // Login Principal method
  Future<void> loginAsPrincipal(String email, String password) async {
    try {
       if (email == 'abc@gmail.com' && password == 'abc1212') {
      _principal = PrincipalModel(
        principalId: 1,
        principalEmailId: email,
        principalPassword: password,
      );
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
    } catch (e) {
      log('Error logging in as principal: $e');
    }
  }
}