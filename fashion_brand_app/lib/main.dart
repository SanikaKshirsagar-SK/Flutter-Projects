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
