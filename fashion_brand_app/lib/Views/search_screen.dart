import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";

import "../Controllers/home_controller.dart";
import "../widgets.dart";
import "cart_screen.dart";
import "home_screen.dart";

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final HomeController _homeController = Get.find<HomeController>();
  final RxBool _isSearching = false.obs;
// @override
// void dispose() {
//   _searchController.dispose();
//   Get.delete<HomeController>();
//   super.dispose();
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: customAppBar(
        title: "Search Here",
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: GestureDetector(
            onTap: () {
              Get.to(() => const HomeScreen());
            },
            child: SvgPicture.asset("assets/back.svg", width: 30, height: 30),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const CartScreen());
              },
              child: SvgPicture.asset("assets/cart.svg", width: 30, height: 30),
            ),
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Obx(() => _isSearching.value
                ? Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Search results for "${_searchController.text}"',
                          style: textStyleData16(),
                        ),
                      ),
                    ],
                  )
                : customTextField(
                    "Search",
                    controller: _searchController,
                  )),
            const SizedBox(height: 20),
            Obx(() => _isSearching.value
                ? Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: _homeController.searchedProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: _homeController.searchedProducts[index],
                          index: index,
                          
                        );
                      },
                    ),
                  )
                : customButtonRounded(
                    onPressed: () {
                      _homeController.searchProducts(_searchController.text);
                      _isSearching.value = true;
                    },
                    buttonText: "Search",
                  )),
          ],
        ),
      ), );
  }
}
