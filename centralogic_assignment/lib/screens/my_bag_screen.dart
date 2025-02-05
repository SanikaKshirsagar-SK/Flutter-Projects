import 'package:centralogic_assignment/bloc/cart/cart_bloc.dart';
import 'package:centralogic_assignment/bloc/cart/cart_event.dart'
    as cart_events;
import 'package:centralogic_assignment/bloc/cart/cart_event.dart';
import 'package:centralogic_assignment/bloc/cart/cart_state.dart';
import 'package:centralogic_assignment/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const Center(child: Text("Your cart is empty."));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = state.cartItems[index];
                    return ListTile(
                      leading: Image.asset(cartItem.product.image,
                          width: 50, height: 50),
                      title: Text(
                        cartItem.product.name,
                        style: const TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      subtitle: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (cartItem.quantity > 1) {
                                context.read<CartBloc>().add(
                                    cart_events.RemoveFromCart(
                                        cartItem.product));
                              }
                            },
                            child: ClipOval(
                              child: Container(
                                color: AppColors.blueColor,
                                height: 25,
                                width: 25,
                                child: const Icon(Icons.remove,
                                    color: AppColors.whiteColor, size: 18),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text("${cartItem.quantity}",
                              style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              context.read<CartBloc>().add(
                                  cart_events.AddToCart(
                                      cartItem.product, cartItem.quantity));
                            },
                            child: ClipOval(
                              child: Container(
                                color: AppColors.blueColor,
                                height: 25,
                                width: 25,
                                child: const Icon(Icons.add,
                                    color: AppColors.whiteColor, size: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            "\$${cartItem.product.price * cartItem.quantity}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.blueColor),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            child: const Text("Remove",
                                style: TextStyle(color: Colors.red)),
                            onTap: () {
                              context.read<CartBloc>().add(
                                  cart_events.RemoveFromCart(cartItem.product));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          ...state.cartItems.map((cartItem) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(cartItem.product.name,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    Text(
                                        "\$${cartItem.product.price * cartItem.quantity}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              )),
                          const Divider(),
                          summaryRow("Subtotal", "\$${state.getSubtotal()}"),
                          const Divider(),
                          summaryRow(
                              "Shipping", "\$${state.getShippingCharges()}"),
                          const Divider(),
                          summaryRow("Total Payment", "\$${state.getTotal()}",
                              isTotal: true),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.read<CartBloc>().add(ClearCart());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Order Successful!")),
              );
              Navigator.pop(context);
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.blueColor),
            child: const Text(
              "Pay Now",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget summaryRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isTotal ? AppColors.blueColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
