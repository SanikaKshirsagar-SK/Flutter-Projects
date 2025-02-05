import 'package:centralogic_assignment/bloc/cart/cart_bloc.dart';
import 'package:centralogic_assignment/data/product_repo.dart';
import 'package:centralogic_assignment/screens/splash_screen.dart';
import 'package:centralogic_assignment/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/product_bloc_state_event.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ProductBloc(ProductRepository())..add(LoadProducts())),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
