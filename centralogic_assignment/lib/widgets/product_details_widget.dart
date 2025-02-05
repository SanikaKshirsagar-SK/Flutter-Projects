import 'package:centralogic_assignment/bloc/cart/cart_bloc.dart';
import 'package:centralogic_assignment/bloc/cart/cart_event.dart';
import 'package:centralogic_assignment/screens/my_bag_screen.dart';
import 'package:centralogic_assignment/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';

void showProductDetailsBottomSheet(BuildContext context, Product product) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      int quantity = 1;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.fill,
                        height: 313,
                        width: 237,
                      )),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.name,
                        style: const TextStyle(
                            fontFamily: "OpenSans",
                            color: AppColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    const Icon(
                      Icons.favorite_border,
                      color: AppColors.blueColor,
                    )
                  ],
                ),
                Image.asset(
                  "assets/images/vendors/gooday.png",
                  // width: 78.64,
                  height: 50,
                ),
                Text(product.description),
                const SizedBox(height: 10),
                const Text(
                  "Review",
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const Row(
                        children: [
                          Icon(
                            Icons.star_rate_rounded,
                            color: AppColors.yellowColor,
                          ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // Text("(4.0)")
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (quantity > 1) {
                          setState(() => quantity--);
                        }
                      },
                      child: ClipOval(
                        child: Container(
                          color: AppColors.blueColor,
                          height: 25,
                          width: 25,
                          child: const Icon(
                            Icons.remove,
                            color: AppColors.whiteColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("$quantity",
                        style: const TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      child: ClipOval(
                        child: Container(
                          color: AppColors.blueColor,
                          height: 25,
                          width: 25,
                          child: const Icon(
                            Icons.add,
                            color: AppColors.whiteColor,
                            size: 18,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() => quantity++);
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("\$${product.price}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blueColor)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48)),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);

                            context
                                .read<CartBloc>()
                                .add(AddToCart(product, quantity));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CheckoutScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blueColor),
                          child: const Text("Add to Cart",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.whiteColor)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 45,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            border: Border.all(color: AppColors.blueColor)),
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<CartBloc>()
                                .add(AddToCart(product, quantity));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CheckoutScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.whiteColor),
                          child: const Text("Buy Now",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blueColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
