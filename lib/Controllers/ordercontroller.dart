import 'dart:developer';
import 'package:get/get.dart';
import '../Models/orderhistorymodel.dart';
import 'databasecontroller.dart';

class OrderController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<OrderModel> orderList = <OrderModel>[].obs;

  void addOrderToHistory(OrderModel order) async {
    orderList.add(order);
    DatabaseController databaseController = Get.find();
    log(
      'cart Total in addorderhistory: ${order.cartTotal.toString()}',
    );
    databaseController.insertOrderHistoryData(
        order.products, order.id, order.orderDate, order.cartTotal.toString());
  }

  void removeOrderFromHistory(int index) {
    orderList.removeAt(index);
  }

  Future<List<OrderModel>> fetchOrderList() async {
    isLoading.value = true;
    try {
      DatabaseController databaseController = Get.find();
      orderList.value = await databaseController.fetchOrderHistoryData();
    } catch (e) {
      log('Error fetching order history: $e');
    } finally {
      isLoading.value = false;
    }
    return orderList;
  }
}
