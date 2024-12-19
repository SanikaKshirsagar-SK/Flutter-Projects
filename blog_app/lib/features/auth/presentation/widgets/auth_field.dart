import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;

  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle()
      ),
      obscureText: isObscure,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing !!";
        }
        return null;
      },
    );
  }
}
