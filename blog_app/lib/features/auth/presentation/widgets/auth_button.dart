import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [AppPallet.gradient1, AppPallet.gradient2],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
          borderRadius: BorderRadius.circular(8)),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              // fixedSize: ,
              backgroundColor: AppPallet.transparentColor,
              shadowColor: AppPallet.transparentColor),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )),
    );
  }
}
