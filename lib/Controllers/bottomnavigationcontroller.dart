import 'package:get/get.dart';

import '../Views/cartscreen.dart';
import '../Views/homepage.dart';
import '../Views/searchscreen.dart';
import '../Views/settingscreen.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    currentIndex.listen((index) {
      Future.delayed(const Duration(milliseconds: 100), () {
        navigateToScreen(index);
      });
    });
  }

  void navigateToScreen(int index) {
    switch (index) {
      case 0:
        Get.to(() => const HomeScreen());
        break;
      case 1:
        Get.to(() => const SearchScreen());
        break;
      case 2:
        Get.to(() => const CartScreen());
        break;
      case 3:
        Get.to(() => const SettingsScreen());
        break;
    }
  }
  // @override
  // void onClose() {
  //   Get.delete<SettingsController>();
  //   super.onClose();
  // }
}
