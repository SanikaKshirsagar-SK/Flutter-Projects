import 'package:flutter/material.dart';

TextStyle customTextStyle({
  String fontFamily = "segoe UI",
  FontWeight fontWeight = FontWeight.w400,
  double fontSize = 14,
  Color color = const Color.fromRGBO(255, 255, 255, 1),
}) {
  return TextStyle(
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    fontSize: fontSize,
    color: color,
  );
}
