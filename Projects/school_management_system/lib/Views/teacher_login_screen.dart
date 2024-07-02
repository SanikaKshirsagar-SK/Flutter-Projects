import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/Controllers/teacher_login_controller.dart';

class LoginTeacherScreen extends StatefulWidget {
  const LoginTeacherScreen({super.key});

  @override
  LoginTeacherScreenState createState() => LoginTeacherScreenState();
}

class LoginTeacherScreenState extends State<LoginTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _teacherUsername, _teacherPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Email TextField
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a Username';
                  }
                  return null;
                },
                onSaved: (value) => _teacherUsername = value!,
              ),
              // Password TextField
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a Password';
                  }
                  return null;
                },
                onSaved: (value) => _teacherPassword = value!,
              ),
              const SizedBox(height: 20),
              // Login Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      await Provider.of<TeacherLoginController>(context, listen: false)
                          .loginAsTeacher(_teacherUsername, _teacherPassword);
                      Navigator.pushReplacementNamed(context, '/home');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid credentials')));
                        log('Error log in teacher: $e');

                    }
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
