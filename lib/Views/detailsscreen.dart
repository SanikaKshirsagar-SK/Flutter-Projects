import 'package:brand_store_app/Controllers/cartcontroller.dart';
import 'package:brand_store_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../Controllers/homecontroller.dart';
import '../Models/productmodel.dart';
import 'cartscreen.dart';
import 'homepage.dart';
import 'wishlistscreen.dart';

class DetailsScreen extends StatefulWidget {
  final ProductModel product;
  const DetailsScreen({super.key, required this.product});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  SizeController sizeController = Get.find();
  CartController cartController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: textStylAppBarData(),
        ),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const WishlistScreen());
              },
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  widget.product.image,
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
              sizedBox20(),
              Text(widget.product.title, style: textStyleHeadingData()),
              sizedBox20(),
              Text(
                'Size',
                style: textStyleData(24, 600, 24, [13, 13, 14, 1]),
              ),
              sizedBox10(),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['S', 'M', 'L', 'XL', 'XXL'].map(
                    (size) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Theme(
                          data: ThemeData(
                            chipTheme: ChipThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide.none,
                              ),
                            ),
                          ),
                          child: ChoiceChip(
                            label: Text(size),
                            selected: sizeController.selectedSize.value == size,
                            onSelected: (selected) {
                              sizeController.setSelectedSize(size);
                              widget.product.size = size;
                            },
                            selectedColor: const Color.fromRGBO(13, 13, 14, 1),
                            backgroundColor:
                                const Color.fromRGBO(255, 255, 255, 1),
                            labelStyle: TextStyle(
                              fontFamily: 'Imprima',
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: sizeController.selectedSize.value == size
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(121, 119, 128, 1),
                            ),
                            showCheckmark: false,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              sizedBox20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${widget.product.price.toString()}',
                      style: textStyleHeadingData()),
                  customButtonRounded(
                      onPressed: () async {
                        cartController.addProductToCart(widget.product);
                        Get.to(() => const CartScreen());
                      },
                      buttonText: 'Add To Cart')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
