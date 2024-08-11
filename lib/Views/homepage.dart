import 'package:brand_store_app/Views/detailsscreen.dart';
import 'package:brand_store_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Controllers/bottomnavigationcontroller.dart';
import '../Controllers/databasecontroller.dart';
import '../Controllers/homecontroller.dart';
import '../Models/productmodel.dart';
import 'wishlistscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseController databaseController = Get.find();
  final HomeController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const HomeScreen());
                    },
                    child: SvgPicture.asset('assets/logo1-explore.svg',
                        width: 30, height: 30),
                  ),
                  const Spacer(),
                  sizedBoxWidth10(),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const WishlistScreen());
                    },
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            sizedBox20(),
            Transform.translate(
              offset: const Offset(-20, 0),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: 220,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 122, 0, 1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore',
                      style: textStyleHeadingData(
                          color: const Color.fromRGBO(255, 255, 255, 1)),
                    ),
                    sizedBox10(),
                    const Text('Best trendy collection!',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Imprima',
                            fontWeight: FontWeight.w400,
                            height: 18 / 18)),
                    // sizedBox20(),
                  ],
                ),
              ),
            ),
            sizedBox20(),
            TabBar(
              controller: controller.tabController,
              tabs: controller.tabs.map((tab) => Tab(text: tab)).toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  ProductGrid(products: controller.allProducts),
                  ProductGrid(products: controller.menProducts),
                  ProductGrid(products: controller.womenProducts),
                  ProductGrid(products: controller.otherProducts),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationView(),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final RxList<ProductModel> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          index: index,
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final int index;

  const ProductCard({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final DatabaseController databaseController =
        Get.find<DatabaseController>();
    final RxBool isInWishlist = false.obs;
    databaseController.isProductInWishlist(product.id).then((value) {
      isInWishlist.value = value;
    });

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => DetailsScreen(product: product));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    product.image,
                    height: 194,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Obx(
                    () => CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          if (isInWishlist.value) {
                            databaseController
                                .deleteWishlistData(product.id.toString())
                                .then((_) {
                              isInWishlist.value = false;
                            });
                          } else {
                            databaseController
                                .insertWishlistData(product)
                                .then((_) {
                              isInWishlist.value = true;
                            });
                          }
                        },
                        child: Icon(
                          Icons.favorite,
                          size: 20,
                          color: isInWishlist.value ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\$${product.price}',
                style: textStyleData18(),
              ),
              Text(
                product.title.split(' ').take(3).join(' ').length > 15
                    ? '${product.title.split(' ').take(3).join(' ').substring(0, 15)}...'
                    : '${product.title.split(' ').take(3).join(' ')}...',
                style: textStyleData16grey(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BottomNavigationView extends StatelessWidget {
  final BottomNavigationController _controller =
      Get.find<BottomNavigationController>();

  BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    //  _controller.currentIndex.value = 0;
    return Obx(() => BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          currentIndex: _controller.currentIndex.value,
          onTap: (index) {
            _controller.currentIndex.value = index;
          },
          selectedItemColor: const Color.fromRGBO(255, 122, 0, 1),
          unselectedItemColor: const Color.fromRGBO(13, 13, 14, 1),
          unselectedLabelStyle: textStyleData(12, 400, 12, [13, 13, 14, 1]),
          selectedLabelStyle: textStyleData(12, 400, 12, [255, 122, 0, 1]),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          iconSize: 25,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset('assets/home.svg',
                      width: 25,
                      height: 25,
                      color: _controller.currentIndex.value == 0
                          ? const Color.fromRGBO(255, 122, 0, 1)
                          : const Color.fromRGBO(13, 13, 14, 1)),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset('assets/search.svg',
                      width: 25,
                      height: 25,
                      color: _controller.currentIndex.value == 1
                          ? const Color.fromRGBO(255, 122, 0, 1)
                          : const Color.fromRGBO(13, 13, 14, 1)),
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset('assets/cart.svg',
                      width: 25,
                      height: 25,
                      color: _controller.currentIndex.value == 2
                          ? const Color.fromRGBO(255, 122, 0, 1)
                          : const Color.fromRGBO(13, 13, 14, 1)),
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset('assets/settting.svg',
                      width: 25,
                      height: 25,
                      color: _controller.currentIndex.value == 3
                          ? const Color.fromRGBO(255, 122, 0, 1)
                          : const Color.fromRGBO(13, 13, 14, 1)),
                ),
                label: 'Settings'),
          ],
        ));
  }
}
