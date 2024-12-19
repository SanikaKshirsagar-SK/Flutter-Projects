import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthIsAccount extends StatelessWidget {
  final String text1;
  final String text2;
  const AuthIsAccount({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(text: text1,style: Theme.of(context).textTheme.titleMedium,
    children: [
      TextSpan(
        text: text2,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppPallet.gradient2,
          fontWeight: FontWeight.bold
        )
      )
    ]));
  }
}
