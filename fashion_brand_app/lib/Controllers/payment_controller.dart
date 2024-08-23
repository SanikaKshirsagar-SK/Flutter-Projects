// import "dart:developer";

import "package:get/get.dart";
import "package:upi_india/upi_india.dart";
import "cart_controller.dart";

class PaymentController extends GetxController {
  final CartController _cartController = Get.find<CartController>();
  final _upiIndia = UpiIndia();
  final _upiApps = Rxn<List<UpiApp>>();
  final _selectedIndex = RxInt(-1);

  void initUpiApps() async {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      _upiApps.value = value;
    }).catchError((e) {
      _upiApps.value = [];
    });
  }

  List<UpiApp>? get upiApps => _upiApps.value;
  int get selectedIndex => _selectedIndex.value;

  void selectIndex(int index) {
    _selectedIndex.value = index;
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
        app: app,
        receiverName: "Sanika Kshirsagar",
        transactionNote: "Make Payment..",
        receiverUpiId: "7448117458@ybl",
        transactionRefId: "Payment of received",
        amount: double.parse(_cartController.total.toStringAsFixed(2)));
  }
}
