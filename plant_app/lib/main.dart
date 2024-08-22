import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/cart_controller.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/database_controller.dart';
import 'controllers/firebase_controller.dart';
import 'controllers/order_controller.dart';
import 'controllers/plant_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/search_controller.dart';
import 'controllers/wishlist_controller.dart';
import 'screens/first_screen.dart';
import 'screens/plant_category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        Get.put(FirebaseController());
        Get.put(PlantController());
        Get.put(DashboardController());
        Get.put(ProfileController());
        Get.put(OrderController());
        Get.put(WishlistController());
        Get.put(PlantCategoriesController());
        Get.put(SearchController1());
      }),
      home: const FirstScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1)),
    );
  }
}
