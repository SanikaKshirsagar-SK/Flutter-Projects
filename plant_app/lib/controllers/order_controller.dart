import 'dart:developer';
import 'package:get/get.dart';
import '../model/order_history_model.dart';
import 'database_controller.dart';

class OrderController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<OrderModel> orderList = <OrderModel>[].obs;

  void addOrderToHistory(OrderModel order) async {
    orderList.add(order);
    DatabaseController databaseController = Get.find();
    log(
      "cart Total in addorderhistory: ${order.cartTotal.toString()}",
    );
    databaseController.insertOrderHistoryData(
        order.plants, order.id, order.orderDate, order.cartTotal.toString());
    update();
  }

  void removeOrderFromHistory(int index) {
    orderList.removeAt(index);
    update();
  }

  Future<List<OrderModel>> fetchOrderList() async {
    isLoading(true);

    try {
      DatabaseController databaseController = Get.find();
      orderList.value = await databaseController.fetchOrderHistoryData();
    } catch (e) {
      log("Error fetching order history: $e");
    } finally {
      isLoading(false);
    }
    return orderList;
  }
}
