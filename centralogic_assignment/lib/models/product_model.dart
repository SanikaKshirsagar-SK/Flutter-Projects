import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  Product({required this.id, required this.name, required this.description, required this.price, required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }

  static List<Product> fromJsonList(String jsonStr) {
    final data = json.decode(jsonStr) as List;
    return data.map((e) => Product.fromJson(e)).toList();
  }
}
