import 'package:centralogic_assignment/theme/app_colors.dart';
import 'package:centralogic_assignment/widgets/head_row_widget.dart';
import 'package:centralogic_assignment/widgets/product_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc_state_event.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final List<String> vendors = [
    "assets/images/vendors/gooday.png",
    "assets/images/vendors/crane_co.png",
    "assets/images/vendors/kuromi.png",
    "assets/images/vendors/wearhouse_stationery.png"
  ];

  final List<Map<String, String>> authors = [
    {
      "image": "assets/images/authors/tessa.png",
      "name": "Tessa",
      "role": "Novolist"
    },
    {
      "image": "assets/images/authors/john.png",
      "name": "John",
      "role": "Author"
    },
    {
      "image": "assets/images/authors/richard.png",
      "name": "Richard",
      "role": "Poet"
    },
  ];

    int selectedIndex = 0;
    const List<BottomNavigationBarItem> bottomNavBarItems =
        <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.category_sharp),
        label: "Category",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_rounded),
        label: "Cart",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people_rounded),
        label: "Profile",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.blackColor),
        ),
        leading: const Icon(Icons.search, size: 24),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.notifications_none_rounded, size: 24),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 162,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white1Color),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Special Offer",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: AppColors.blackColor,
                                fontFamily: "Roboto"),
                          ),
                          const Text(
                            "Discount 25%",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontFamily: "Roboto"),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 116,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.blueColor),
                            child: const Text(
                              "Order Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: AppColors.whiteColor,
                                  fontFamily: "Roboto"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(3.14),
                        child: Image.asset(
                          "assets/images/books/apollo.png",
                          height: 145,
                          width: 99,
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == 0
                              ? AppColors.blueColor
                              : AppColors.lightColor),
                    ),
                  );
                }),
              ),

              headRowWidget("Top of Week"),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductError) {
                    return const Center(child: Text("Error loading products"));
                  }
                  if (state is! ProductLoaded) return const SizedBox.shrink();

                  final products = state.products;
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: GestureDetector(
                            onTap: () {
                              showProductDetailsBottomSheet(context, product);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    product.image,
                                    height: 150,
                                    width: 127,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackColor),
                                ),
                                Text(
                                  "\$${product.price}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blueColor),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              headRowWidget("Best Vendors"),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: vendors.length, 
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset(vendors[index]),
                    );
                  },
                ),
              ),

              headRowWidget("Authors"),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: authors.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              authors[index]["image"]!,
                              height: 102,
                              width:
                                  102, 
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            authors[index]["name"]!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor),
                          ),
                          Text(
                            authors[index]["role"]!,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyColor),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white1Color,
        items: bottomNavBarItems,
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.blueColor,
        unselectedItemColor: AppColors.greyColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
