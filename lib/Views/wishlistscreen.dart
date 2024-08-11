// wishlist_screen.dart
import 'package:brand_store_app/Views/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../Controllers/cartcontroller.dart';
import '../Controllers/homecontroller.dart';
import '../Models/productmodel.dart';
import '../widgets.dart';
import 'homepage.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistController _wishlistController = Get.find();
  // @override
  // void dispose() {
  //   Get.delete<WishlistController>();
  //   Get.delete<CartController>();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    _wishlistController.fetchWishlistDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: customAppBar(
        title: 'Wishlist',
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset('assets/back.svg', width: 30, height: 30),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const CartScreen());
              },
              child: SvgPicture.asset('assets/cart.svg', width: 30, height: 30),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() => _wishlistController.wishlist.isEmpty
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Icon(
                      Icons.hourglass_empty,
                      size: 100,
                    ),
                    sizedBox20(),
                    sizedBox20(),
                    Text(
                      'Your wishlist is empty',
                      style: textStyleData18(),
                    ),
                    sizedBox10(),
                    Text(
                      'Add products to your wishlist to see them here',
                      style: textStyleData16grey(),
                    ),
                    sizedBox20(),
                    sizedBox20(),
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
                  ]))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                ),
                itemCount: _wishlistController.wishlist.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      sizedBox20(),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: Image.network(
                                _wishlistController.wishlist[index].image,
                                height: 194,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  _wishlistController.removeProductFromWishlist(
                                      _wishlistController.wishlist[index]);
                                },
                                child: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.close,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '\$${_wishlistController.wishlist[index].price}',
                              style: textStyleData18(),
                            ),
                            Text(
                              _wishlistController.wishlist[index].title
                                          .split(' ')
                                          .take(3)
                                          .join(' ')
                                          .length >
                                      15
                                  ? '${_wishlistController.wishlist[index].title.split(' ').take(3).join(' ').substring(0, 15)}...'
                                  : '${_wishlistController.wishlist[index].title.split(' ').take(3).join(' ')}...',
                              style: textStyleData16grey(),
                            ),
                            sizedBox10(),
                            SizedBox(
                              height: 35,
                              child: customButtonRounded(
                                onPressed: () {
                                  ProductModel product =
                                      _wishlistController.wishlist[index];
                                  cartController.addProductToCart(
                                      _wishlistController.wishlist[index]);
                                  _wishlistController.removeProductFromWishlist(
                                      _wishlistController.wishlist[index]);
                                  _wishlistController.updateIsInWishlist(
                                      product, false);
                                },
                                buttonText: 'Move to Cart',
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )),
      ),
    );
  }
}
