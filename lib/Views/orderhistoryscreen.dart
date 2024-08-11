// import 'dart:developer';

import 'package:brand_store_app/Views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../Controllers/ordercontroller.dart';
import '../Models/orderhistorymodel.dart';
import '../Models/productmodel.dart';
import '../widgets.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final OrderController _orderController = Get.find<OrderController>();
  @override
  void initState() {
    super.initState();
    _orderController.fetchOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          title: Text('Order History', style: textStylAppBarData()),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const HomeScreen());
              },
              child: SvgPicture.asset('assets/back.svg', width: 30, height: 30),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Obx(
            () => _orderController.orderList.isEmpty
                ? _buildEmptyCart()
                : ListView.builder(
                    itemCount: _orderController.orderList.length,
                    itemBuilder: (context, index) {
                      OrderModel order = _orderController.orderList[index];
                      return Card(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order ID: ${order.id}',
                                style:
                                    textStyleData(16, 400, 18, [13, 13, 14, 1]),
                              ),
                              sizedBox10(),
                              Text(
                                'Order Date: ${order.orderDate}',
                                style:
                                    textStyleData(16, 400, 18, [13, 13, 14, 1]),
                              ),
                              sizedBox10(),
                              Text(
                                'Cart Total: \$${order.cartTotal.toStringAsFixed(2)}',
                                style:
                                    textStyleData(26, 600, 18, [13, 13, 14, 1]),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: order.products.length,
                                itemBuilder: (context, productIndex) {
                                  ProductModel product =
                                      order.products[productIndex];
                                  double productTotal =
                                      product.price * product.quantity;
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: Image.network(product.image,
                                            width: 80, height: 80),
                                        title: Text(
                                          product.title
                                                      .split(' ')
                                                      .take(3)
                                                      .join(' ')
                                                      .length >
                                                  15
                                              ? '${product.title.split(' ').take(3).join(' ').substring(0, 15)}...'
                                              : '${product.title.split(' ').take(3).join(' ')}...',
                                          style: textStyleData(
                                              14, 400, 26, [13, 13, 14, 1]),
                                        ),
                                        subtitle: Text(
                                          'Quantity: ${product.quantity}',
                                          style: textStyleData(
                                              14, 400, 26, [121, 119, 128, 1]),
                                        ),
                                        trailing: Text(
                                          '\$${productTotal.toStringAsFixed(2)}',
                                          style: textStyleData(
                                              24, 600, 26, [13, 13, 14, 1]),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ));
  }
}

Widget _buildEmptyCart() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('assets/emptybag1.png'),
        ),
        const SizedBox(height: 50),
        Text('No orders found', style: textStyleData18()),
        const SizedBox(height: 10),
        Text('You have no orders in your history',
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
                    width: 2,
                    color: Color.fromRGBO(255, 122, 0, 1),
                  ),
                ),
              ),
            ),
            onPressed: () {
              Get.to(() => const HomeScreen());
            },
            child: Text(
              'Shop Now',
              style: textStyleData(
                18,
                600,
                18,
                [255, 122, 0, 1],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
