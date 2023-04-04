// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    required this.id,
    required this.products,
  });

  final String id;
  List<Product> products;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        products: List<Product>.from(
            json["Products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.nutrition,
    required this.totalCalories,
    // required this.category,
    // required this.subcategory,
    required this.image,
  });

  final String id;
  final String name;
  final int price;
  final bool nutrition;
   final int totalCalories;
  // final Category category;
  // final Category subcategory;
  final String image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        nutrition: json["nutrition"],
         totalCalories: json["totalCalories"],
        // category: Category.fromJson(json["category"]),
        // subcategory: Category.fromJson(json["subcategory"]),
        image: json["image"],
      );
  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        nutrition: json["nutrition"],
         totalCalories: json["totalCalories"],
        // category: Category.fromJson(json["category"]),
        // subcategory: Category.fromJson(json["subcategory"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "nutrition": nutrition,
        // "category": category.toJson(),
        // "subcategory": subcategory.toJson(),
        "image": image,
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}