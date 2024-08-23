import 'Controllers/cart_controller.dart';
import 'Controllers/profile_controller.dart';
import 'Views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controllers/bottom_navigation_controller.dart';
import 'Controllers/database_controller.dart';
import 'Controllers/order_controller.dart';
import 'Controllers/payment_controller.dart';
import 'Controllers/home_controller.dart';
import 'Views/first_screen.dart';
import 'Views/sign_in_screen.dart';
import 'Views/sign_up_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() async {
        await Get.putAsync<DatabaseController>(() async {
          final controller = DatabaseController();
          await controller.createDB();
          return controller;
        });
        await Get.putAsync<CartController>(() async {
          final controller = CartController();
          return controller;
        });
        Get.put(SizeController());
        Get.put(ProfileController());
        Get.put(OrderController());
        Get.put(WishlistController());
        Get.put(BottomNavigationController());
        Get.put(HomeController());
        Get.put(PaymentController());
      }),
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFFff7a00,
          <int, Color>{
            50: Color(0xFFff7a00),
            100: Color(0xFFff7a00),
            200: Color(0xFFff7a00),
            300: Color(0xFFff7a00),
            400: Color(0xFFff7a00),
            500: Color(0xFFff7a00),
            600: Color(0xFFff7a00),
            700: Color(0xFFff7a00),
            800: Color(0xFFff7a00),
            900: Color(0xFFff7a00),
          },
        ),
      ),
      initialRoute: "/firstScreen",
      // home: const HomeScreen(),
      getPages: [
        GetPage(name: "/firstScreen", page: () => const FirstScreen()),
        GetPage(name: "/signInScreen", page: () => SignInScreen()),
        GetPage(name: "/signUpScreen", page: () => SignUpScreen()),
        GetPage(
          name: "/homescreen",
          page: () => const HomeScreen(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
