import 'package:flutter/material.dart';
import 'package:get_with_model_class/viewemployee.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ViewEmployee(),
    );
  }
}
