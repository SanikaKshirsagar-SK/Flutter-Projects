import 'dart:developer';

import 'package:flutter/material.dart';
import '../Models/teacher_model.dart';
import 'database_controller.dart';

// Provider for TeacherLoginController class
class TeacherLoginController with ChangeNotifier {
  late TeacherModel _teacher;
  late DatabaseHelper _dbHelper;

  TeacherLoginController() {
    _dbHelper = DatabaseHelper();
  }
 
  // Principal getter
  TeacherModel get teacher => _teacher;

  // LoginTeacher method
  Future<TeacherModel?> loginAsTeacher(String username, String password) async {
    try {
      final teacher = await _dbHelper.getTeacher(username, password);
      if (teacher != null) {
        _teacher = teacher;
        notifyListeners();
      }
      return teacher;
    } catch (e) {
      log('Error logging in as teacher: $e');
      return null;
    }
  }
}