import 'package:centralogic_assignment/theme/app_colors.dart';
import 'package:flutter/material.dart';

Widget headRowWidget(String leftText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        leftText,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: "OpenSans",
        ),
      ),
    const Text(
        "See all",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: "Roboto",
          color: AppColors.blueColor,
        ),
      ),
    ],
  );
}
