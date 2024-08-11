import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/productmodel.dart';
import 'databasecontroller.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxList<String> tabs = ['All', 'Men', 'Women', 'Other'].obs;
  final RxInt currentIndex = 0.obs;

  final RxList<ProductModel> allProducts = <ProductModel>[].obs;
  final RxList<ProductModel> menProducts = <ProductModel>[].obs;
  final RxList<ProductModel> womenProducts = <ProductModel>[].obs;
  final RxList<ProductModel> otherProducts = <ProductModel>[].obs;
  final RxList<ProductModel> searchedProducts = <ProductModel>[].obs;

  void searchProducts(String query) {
    searchedProducts.clear();
    for (var product in allProducts) {
      if (product.title.toLowerCase().contains(query.toLowerCase())) {
        searchedProducts.add(product);
      }
    }
  }

  late TabController tabController;
  DatabaseController databaseController = Get.find();

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: tabs.length);
    super.onInit();
    fetchProducts();
    databaseController.fetchWishlistData();
    databaseController.fetchCartData();
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final products = (jsonData as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
      allProducts.value = products;
      menProducts.value = products
          .where((product) => product.category == 'men\'s clothing')
          .toList();
      womenProducts.value = products
          .where((product) => product.category == 'women\'s clothing')
          .toList();
      otherProducts.value = products
          .where((product) =>
              product.category == 'jewelery' ||
              product.category == 'electronics')
          .toList();
    } else {
      log('Failed to load products');
    }
  }
}

class SizeController extends GetxController {
  final RxString _selectedSize = 'L'.obs;

  RxString get selectedSize => _selectedSize;

  void setSelectedSize(String size) {
    _selectedSize.value = size;
  }
}

class WishlistController extends GetxController {
  RxList<ProductModel> wishlist = <ProductModel>[].obs;
  late DatabaseController databaseController;
  RxBool isInWishlist = false.obs;

  @override
  void onInit() {
    super.onInit();
    databaseController = Get.find<DatabaseController>();
    fetchWishlistDataFromDB();
  }

  void fetchWishlistDataFromDB() async {
    List<ProductModel> wishlistData =
        await databaseController.fetchWishlistData();
    wishlist.assignAll(wishlistData);
  }

  void addProductToWishlist(ProductModel product) async {
    if (!wishlist.contains(product)) {
      await databaseController.insertWishlistData(product);
      wishlist.add(product);
    } else {
      log('Product is already in the wishlist.');
    }
  }

  void removeProductFromWishlist(ProductModel product) async {
    if (wishlist.contains(product)) {
      await databaseController.deleteWishlistData(product.id.toString());
      wishlist.remove(product);
    }
    update();
  }

  void updateIsInWishlist(ProductModel product, bool value) {
    product.isInWishlist = value;
    update();
  }
}
