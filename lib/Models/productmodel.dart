class ProductModel {
  final int id;
  final String title;
  final String image;
  double price;
  String? size;
  final String category;
  int quantity;
  bool isInWishlist;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.size = 'M',
    required this.category,
    this.quantity = 1,
    this.isInWishlist = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'].toDouble(),
      size: json['size'],
      category: json['category'],
      quantity: json['quantity'] ?? 1,
      isInWishlist: json['isInWishlist'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'size': size,
      'category': category,
      'quantity': quantity,
      'isInWishlist': isInWishlist,
    };
  }

  ProductModel copyWith({
    int? id,
    String? title,
    String? image,
    double? price,
    String? size,
    int? quantity,
    String? category,
    bool? isInWishlist,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      isInWishlist: isInWishlist ?? this.isInWishlist,
    );
  }
}
