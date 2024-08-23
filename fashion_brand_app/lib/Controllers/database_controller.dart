import 'dart:developer';
import '../Models/product_model.dart';
import '../Models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';

import '../Models/order_history_model.dart';

class DatabaseController extends GetxController {
  static Database? _database;


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDB();
    return _database!;
  }

  createDB() async {
    return openDatabase(
      path.join(await getDatabasesPath(), "UserDB.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
            CREATE TABLE UserData(
              Id INTEGER PRIMARY KEY ,
              name TEXT,
              username TEXT,
              password TEXT
            )''');
        db.execute('''
            CREATE TABLE CartData(
              Id INTEGER PRIMARY KEY ,
              productId TEXT,
              title TEXT,
              image TEXT,
              price REAL,
              size TEXT,
              quantity INTEGER
            )''');

        db.execute('''
            CREATE TABLE WishlistData(
              Id INTEGER PRIMARY KEY ,
              productId TEXT,
              title TEXT,
              image TEXT,
              price REAL,
              isInWishlist INTEGER DEFAULT 0 
            )''');
        db.execute('''
          CREATE TABLE OrderHistoryData(
            Id INTEGER PRIMARY KEY ,
            orderId TEXT,
            title TEXT,
            image TEXT,
            cartTotal REAL,
            price REAL,
            size TEXT,
            quantity INTEGER,
            orderDate TEXT
          )''');
        log("User Data Table created");
        log("Cart Data Table created");
        log("Wishlist Data Table created");
        log("Order History Data Table created");
      },
    );
  }

  Future<void> insertUserData(UserModel obj) async {
    final localDB = await database;
    localDB.insert(
      "UserData",
      obj.userMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    log("User Data Inserted");
    update();
  }

  Future<List<UserModel>> fetchUserData() async {
    final localDB = await database;

    List<Map<String, dynamic>> userData = await localDB.query("UserData");

    return List.generate(userData.length, (idx) {
      return UserModel(
        id: userData[idx]["id"],
        name: userData[idx]["name"],
        username: userData[idx]["username"],
        password: userData[idx]["password"],
      );
    });
  }

  Future<void> updateUserData(UserModel obj) async {
    final localDB = await database;
    localDB.update(
      "UserData",
      obj.userMap(),
      where: "username = ?",
      whereArgs: [obj.username],
    );
    log("User Data Updated");
    update();
  }

  Future<void> insertCartData(ProductModel obj) async {
    final localDB = await database;
    localDB.insert(
      "CartData",
      {
        "productId": obj.id,
        "title": obj.title,
        "image": obj.image,
        "price": obj.price,
        "size": obj.size,
        "quantity": obj.quantity,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    log("Cart Data Inserted");
    update();
  }

  Future<void> updateCartData(ProductModel obj) async {
    final localDB = await database;
    localDB.update(
      "CartData",
      {
        "productId": obj.id,
        "title": obj.title,
        "image": obj.image,
        "price": obj.price,
        "size": obj.size,
        "quantity": obj.quantity,
      },
      where: "productId = ?",
      whereArgs: [obj.id],
    );
    log("Cart Data Updated");
    update();
  }

  Future<List<ProductModel>> fetchCartData() async {
    final localDB = await database;
    List<Map<String, dynamic>> cartData = await localDB.query("CartData");
    return List.generate(cartData.length, (idx) {
      return ProductModel(
        id: int.parse(cartData[idx]["productId"]),
        title: cartData[idx]["title"],
        image: cartData[idx]["image"],
        price: cartData[idx]["price"],
        size: cartData[idx]["size"],
        quantity: cartData[idx]["quantity"],
        category: cartData[idx]["category"] ?? "",
      );
    });
  }

  Future<void> deleteCartData(int id) async {
    final localDB = await database;
    localDB.delete(
      "CartData",
      where: "productId = ?",
      whereArgs: [id],
    );
    log("Cart Data Deleted");
    update();
  }

  Future<void> insertWishlistData(ProductModel obj) async {
    final localDB = await database;
    localDB.insert(
      "WishlistData",
      {
        "productId": obj.id,
        "title": obj.title,
        "image": obj.image,
        "price": obj.price,
        "isInWishlist": 1,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    log("Wishlist Data Inserted");
    update();
  }

  Future<void> updateWishlistData(ProductModel obj) async {
    final localDB = await database;
    localDB.update(
      "WishlistData",
      {
        "isInWishlist": 0,
      },
      where: "productId = ?",
      whereArgs: [obj.id],
    );
    log("Wishlist Data Updated");
    update();
  }

  Future<List<ProductModel>> fetchWishlistData() async {
    final localDB = await database;

    List<Map<String, dynamic>> wishlistData =
        await localDB.query("WishlistData");

    return List.generate(wishlistData.length, (idx) {
      return ProductModel(
        id: int.parse(wishlistData[idx]["productId"]),
        title: wishlistData[idx]["title"],
        image: wishlistData[idx]["image"],
        price: wishlistData[idx]["price"],
        category: wishlistData[idx]["category"] ?? "",
        isInWishlist: wishlistData[idx]["isInWishlist"] == 1,
      );
    });
  }

  Future<void> deleteWishlistData(String productId) async {
    final localDB = await database;
    localDB.delete(
      "WishlistData",
      where: "productId = ?",
      whereArgs: [productId],
    );
    log("Wishlist Data Deleted");
    update();
  }

  Future<bool> isProductInWishlist(int productId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      "WishlistData",
      where: "productId = ?",
      whereArgs: [productId],
    );
    return result.isNotEmpty;
  }

  Future<void> insertOrderHistoryData(List<ProductModel> products,
      String orderId, String orderDate, String cartTotal) async {
    final localDB = await database;
    for (var product in products) {
      localDB.insert(
        "OrderHistoryData",
        {
          "orderId": orderId,
          "title": product.title,
          "image": product.image,
          "cartTotal": cartTotal,
          "size": product.size,
          "price": product.price,
          "quantity": product.quantity,
          "orderDate": orderDate,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    log("Order History Data Inserted");
    update();
  }

  // Future<double> getProductPriceFromCartData(String title) async {
  //   final localDB = await database;
  //   List<Map<String, dynamic>> productData = await localDB.query(
  //     "CartData",
  //     where: "title = ?",
  //     whereArgs: [title],
  //   );
  //   if (productData.isNotEmpty) {
  //     return productData.first["price"];
  //   } else {
  //     return 0.0;
  //   }
  // }

  Future<List<OrderModel>> fetchOrderHistoryData() async {
    List<OrderModel> orders = [];

    try {
      final db = await database;
      List<Map<String, dynamic>> data = await db.query("OrderHistoryData");
      Map<String, List<Map<String, dynamic>>> orderGroups = {};
      for (var order in data) {
        if (!orderGroups.containsKey(order["orderId"])) {
          orderGroups[order["orderId"]] = [];
        }
        orderGroups[order["orderId"]]?.add(order);
      }
      for (var orderId in orderGroups.keys) {
        List<Map<String, dynamic>> orderData = orderGroups[orderId]!;
        OrderModel order = OrderModel(
          id: orderId,
          title: orderData.first["title"] ?? "",
          image: orderData.first["image"] ?? "",
          orderDate: orderData.first["orderDate"] ?? "",
          cartTotal: orderData.first["cartTotal"] ?? "",
          price: orderData.first["price"] ?? "",
          products: [],
        );
        for (var productData in orderData) {
          log("product price : ${productData["price"]}");
          log("product productId : ${productData["productId"]}");
          log("product title : ${productData["title"]}");
          // double price = await getProductPriceFromCartData(productData["title"] ?? "");
          ProductModel product = ProductModel(
            id: int.parse(productData["productId"] ?? "0"),
            title: productData["title"] ?? "",
            image: productData["image"] ?? "",
            price: productData["price"],
            size: productData["size"] ?? "",
            quantity: productData["quantity"] ?? 0,
            category: productData["category"] ?? "",
          );
          order.products.add(product);
        }
        orders.add(order);
      }
    } catch (e) {
      log("Error fetching order history data: $e");
    }
    return orders;
  }
}
