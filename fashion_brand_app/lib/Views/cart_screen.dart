import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:intl/intl.dart";

import "../Controllers/cart_controller.dart";
import "../Controllers/order_controller.dart";
import "../Controllers/home_controller.dart";
import "../Models/order_history_model.dart";
import "../Models/product_model.dart";
import "../widgets.dart";
import "home_screen.dart";
import "payment_options_screen.dart";

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final CartController _cartController = Get.find<CartController>();
  final OrderController _orderController = Get.find<OrderController>();
  WishlistController wishlistController = Get.find<WishlistController>();

  @override
  void initState() {
    super.initState();
    _cartController.fetchCartDataFromDB();
  }

  Widget _buildCartProductItem(int index) {
    return Slidable(
      closeOnScroll: true,
      key: UniqueKey(),
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const DrawerMotion(),
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 5),
                  Container(
                    height: 70,
                    width: 190,
                    padding: const EdgeInsets.only(left: 20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(15),
                      ),
                      color: Color.fromRGBO(76, 61, 59, 1),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: SvgPicture.asset(
                            "assets/heart.svg",
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            height: 25,
                            width: 25,
                          ),
                          onTap: () {
                            ProductModel currentProduct =
                                _cartController.cartProducts[index];

                            if (!wishlistController.wishlist.any(
                                (product) => product.id == currentProduct.id)) {
                              wishlistController
                                  .addProductToWishlist(currentProduct);
                            }
                            _cartController
                                .removeProductFromCart(currentProduct);

                            Slidable.of(context)?.close();
                          },
                        ),
                        const SizedBox(width: 10),
                        sizedBoxWidth20(),
                        sizedBoxWidth20(),
                        GestureDetector(
                            child: SvgPicture.asset(
                              "assets/delete.svg",
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              height: 25,
                              width: 25,
                            ),
                            onTap: () {
                              ProductModel currentProduct =
                                  _cartController.cartProducts[index];
                              _cartController
                                  .removeProductFromCart(currentProduct);
                              Slidable.of(context)?.close();
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      direction: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.only(left: 30),
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                _cartController.cartProducts[index].image,
                width: 108,
                height: 142,
                fit: BoxFit.fill,
              ),
            ),
            sizedBoxWidth20(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _cartController.cartProducts[index].title
                                .split(" ")
                                .take(3)
                                .join(" ")
                                .length >
                            15
                        ? "${_cartController.cartProducts[index].title.split(" ").take(3).join(" ").substring(0, 15)}..."
                        : "${_cartController.cartProducts[index].title.split(" ").take(3).join(" ")}...",
                    style: textStyleData18(),
                  ),
                  Text(
                    "Size ${_cartController.cartProducts[index].size}",
                    style: textStyleData(14, 400, 18, [121, 119, 128, 1]),
                  ),
                  Text(
                    "₹${_cartController.cartProducts[index].price * (_cartController.cartProducts[index].quantity)}",
                    style: textStyleData(26, 400, 26, [13, 13, 14, 1]),
                  ),
                ],
              ),
            ),
            sizedBoxWidth20(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _cartController.decrementProductCount(index);
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Color.fromRGBO(13, 13, 14, 1),
                    size: 25,
                  ),
                ),
                sizedBoxWidth10(),
                Obx(() => Text(
                      "${_cartController.cartProducts[index].quantity}",
                      style: textStyleHeadingData(),
                    )),
                sizedBoxWidth10(),
                GestureDetector(
                  onTap: () {
                    _cartController.incrementProductCount(index);
                  },
                  child: const Icon(
                    Icons.add,
                    color: Color.fromRGBO(13, 13, 14, 1),
                    size: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 40,
            )
          ],
        ),
      ),
    );
  }

  Widget buildCartSummary() {
    _cartController.updateTotal(_cartController.cartTotal.value);
    _cartController.updateTotalQuantity(_cartController.totalCount.value);

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const Divider(
            thickness: 2,
          ),
          sizedBox20(),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Items (${_cartController.totalCount.value})",
                    style: textStyleData(18, 400, 18, [121, 119, 128, 1]),
                  ),
                  Text(
                    "₹${_cartController.totalPrice.value.toStringAsFixed(2)}",
                    style: textStyleData(18, 600, 18, [13, 13, 14, 1]),
                  ),
                ],
              )),
          sizedBox20(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Standard Delivery ",
                style: textStyleData(18, 400, 18, [121, 119, 128, 1]),
              ),
              Text(
                "\$${_cartController.deliveryCharge.value.toStringAsFixed(2)}",
                style: textStyleData(18, 600, 18, [13, 13, 14, 1]),
              ),
            ],
          ),
          sizedBox20(),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Payment ",
                    style: textStyleData(18, 400, 18, [121, 119, 128, 1]),
                  ),
                  Text(
                    "\$${(_cartController.cartTotal.toStringAsFixed(2))}",
                    style: textStyleData(18, 600, 18, [13, 13, 14, 1]),
                  ),
                ],
              )),
          sizedBox20(),
          sizedBox20(),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return customButtonRounded(
      onPressed: () {
        log(
          "Cart Total from cartcontroller: ${_cartController.cartTotal.value.toString()}",
        );
        log(
          "Total price from cartcontroller: ${_cartController.totalPrice.value.toString()}",
        );
        log(
          "Total from cartcontroller: ${_cartController.total}",
        );
        OrderModel newOrder = OrderModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: "Order ${_orderController.orderList.length + 1}",
          image: _cartController.cartProducts[0].image,
          orderDate: DateFormat("dd MMMM yyyy, HH:mm").format(DateTime.now()),
          cartTotal: _cartController.cartTotal.value,
          price: 0.0,
          products: _cartController.cartProducts.toList(),
        );

        for (var product in _cartController.cartProducts) {
          newOrder.price += product.price;
          // newOrder.products.add(product);
        }
        _orderController.addOrderToHistory(newOrder);

        for (var product in _cartController.cartProducts) {
          _cartController.removeProductFromCart(product);
        }

        _cartController.cartProducts.clear();
        _cartController.updateCountsAndPrices();
        Get.to(() => const PaymentOptionsView());
      },
      buttonText: "Checkout Now",
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage("assets/emptybag1.png"),
          ),
          const SizedBox(height: 50),
          Text("Your cart is empty", style: textStyleData18()),
          const SizedBox(height: 10),
          Text("Add products to your cart to see them here",
              style: textStyleData18(color: Colors.grey)),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  const Color.fromRGBO(255, 255, 255, 1),
                ),
                shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      width: 4,
                      color: Color.fromRGBO(76, 61, 59, 1),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Get.to(const HomeScreen());
              },
              child: Text(
                "Shop Now",
                style: textStyleData(20, 500, 20, [76, 61, 59, 1]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: Text("Cart", style: textStylAppBarData()),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: GestureDetector(
            onTap: () {
              Get.to(() => const HomeScreen());
            },
            child: SvgPicture.asset("assets/back.svg", width: 30, height: 30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
        child: Obx(() => _cartController.cartProducts.isEmpty
            ? _buildEmptyCart()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _cartController.cartProducts.length,
                      itemBuilder: (context, index) {
                        return _buildCartProductItem(index);
                      },
                    ),
                  ),
                  buildCartSummary(),
                  _buildCheckoutButton(),
                ],
              )),
      ),
    );
  }
}
