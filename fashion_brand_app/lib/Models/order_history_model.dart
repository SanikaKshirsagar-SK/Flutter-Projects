import "product_model.dart";

class OrderModel {
  String id;
  String title;
  String image;
  String orderDate;
  double cartTotal;
  double price;
  List<ProductModel> products;

  OrderModel({
    required this.id,
    required this.title,
    required this.image,
    required this.orderDate,
    required this.cartTotal,
    required this.products,
    required this.price,

  });

  Map<String, dynamic> orderMap() {
    return {
      "id": id,
      "title": title,
      "image": image,
      "orderDate": orderDate,
      "cartTotal": cartTotal,
      "price": price,
      "products": products.map((product) => product.toJson()).toList(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      orderDate: json["orderDate"],
      cartTotal: json["cartTotal"]?.toDouble() ?? 0,
      price: json["price"]?.toDouble() ?? 0,

      products: json["products"]
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList(),
    );
  }
}