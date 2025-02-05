import 'package:flutter/services.dart' show rootBundle;
import '../models/product_model.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    final jsonStr = await rootBundle.loadString('assets/products.json');
    return Product.fromJsonList(jsonStr);
  }
}
