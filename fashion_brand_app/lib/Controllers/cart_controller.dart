import "dart:developer";
import "package:get/get.dart";

import "../Models/product_model.dart";
import "database_controller.dart";

class CartController extends GetxController {
  RxList<ProductModel> cartProducts = <ProductModel>[].obs;
  RxInt totalCount = 0.obs;
  RxDouble totalPrice = 0.0.obs;
  RxDouble deliveryCharge = 12.0.obs;

  RxDouble cartTotal = 0.0.obs;
  DatabaseController databaseController = Get.find();

  void fetchCartDataFromDB() async {
    List<ProductModel> cartData = await databaseController.fetchCartData();
    cartProducts.value = cartData;
  }

  Future<void> addProductToCart(ProductModel product) async {
    int index = cartProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      //already exists
      cartProducts[index] = cartProducts[index].copyWith(
        quantity: cartProducts[index].quantity + 1,
      );
      await databaseController.updateCartData(cartProducts[index]);
    } else {
      //does not exist
      cartProducts.add(product);
      await databaseController.insertCartData(product);
    }
    updateCountsAndPrices();
    log("Product added to cart");
    update();
  }

  Future<void> removeProductFromCart(ProductModel product) async {
    await databaseController.deleteCartData(product.id);
    cartProducts.removeWhere((element) => element.id == product.id);
    updateCountsAndPrices();
    log("Product removed from cart");
    update();
  }

  void incrementProductCount(int index) {
    if (index >= 0 && index < cartProducts.length) {
      cartProducts[index] = cartProducts[index]
          .copyWith(quantity: cartProducts[index].quantity + 1);
      databaseController.updateCartData(cartProducts[index]);
      updateCountsAndPrices();
    }
    update();
  }

  void decrementProductCount(int index) {
    if (index >= 0 && index < cartProducts.length) {
      if (cartProducts[index].quantity > 1) {
        cartProducts[index] = cartProducts[index]
            .copyWith(quantity: cartProducts[index].quantity - 1);
        databaseController.updateCartData(cartProducts[index]);
      } else {
        removeProductFromCart(cartProducts[index]);
      }
      updateCountsAndPrices();
      update();
    }
  }

  void updateCountsAndPrices() {
    int totalItems = 0;
    double totalPayment = 0.0;
    for (var product in cartProducts) {
      totalItems += product.quantity;
      totalPayment += product.price * (product.quantity);
    }
    totalCount.value = totalItems;
    totalPrice.value = totalPayment;
    log("Total Price: ${totalPrice.value.toString()}");
    cartTotal.value = totalPayment + deliveryCharge.value;
    log(
      "Cart Total: ${cartTotal.value.toString()}",
    );
    refresh();
  }

  double _total = 0.0;

  double get total => _total;

  void updateTotal(double newTotal) {
    _total = newTotal;
    update();
  }

  int _totalQuantity = 0;

  int get totalQuantity => _totalQuantity;

  void updateTotalQuantity(int quantity) {
    _totalQuantity = quantity;
    update();
  }
}
