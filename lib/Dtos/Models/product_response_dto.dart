// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

import '../../Screens/index.dart';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.inCart,
    required this.nutrition,
    required this.category,
    required this.subcategory,
    required this.status,
    required this.ingredients,
    required this.time,
    required this.image,
    required this.totalCalories,
    required this.isDeleted,
  });
  final bool isDeleted;
  final String id;
  final String name;
  final String description;
  final int? price;
  final int totalCalories;
  final bool inCart;
  final bool nutrition;
  final Category? category;
  final Subcategory? subcategory;
  final bool? status;
  final List<Ingredient>? ingredients;
  final int? time;
  final String image;

  void toggleCart() {
    // inCart = !inCart;
    debugPrint('El valor de "inCart"  es $inCart');
  }
  factory Products.fromMap(Map<String, dynamic> json) => Products(
        id: json["_id"].toString(),
        name: json["name"],
        description: json["description"],
        price: json["price"],
        totalCalories: json["totalCalories"],
        inCart: json["inCart"],
        nutrition: json["nutrition"],
        category: Category.fromJson(json["category"]),
        subcategory: Subcategory.fromJson(json["subcategory"]),
        status: json["status"],
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
        time: json["time"],
        image: json["image"],
        isDeleted: json["isDeleted"] as bool? ?? true,
      );

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["_id"].toString(),
        name: json["name"],
        description: json["description"],
        price: json["price"],
        totalCalories: json["totalCalories"],
        inCart: json["inCart"],
        nutrition: json["nutrition"] as bool? ?? false,
        // Si el valor es nulo, se asigna false a la variable
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"] as Map<String, dynamic>),
        subcategory: json["subcategory"] == null
            ? null
            : Subcategory.fromJson(json["subcategory"] as Map<String, dynamic>),
        // subcategory: Category.fromJson(json["subcategory"]),
        status: json["status"],
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
        time: json["time"],
        image: json["image"],
        isDeleted: json["isDeleted"] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "totalCalories": totalCalories,
        "inCart": inCart,
        "nutrition": nutrition,
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
        "status": status,
        "ingredients": List<dynamic>.from(ingredients!.map((x) => x.toJson())),
        "time": time,
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

class Subcategory {
  Subcategory({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Ingredient {
  Ingredient({
    required this.value,
    required this.name,
    required this.calories,
    required this.unidad,
    required this.weight,
  });

  final String value;
  final String name;
  final String calories;
  final String unidad;
  final String weight;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        value: json["value"],
        name: json["name"],
        calories: json["calories"],
        unidad: json["unidad"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
        "calories": calories,
        "unidad": unidad,
        "weight": weight,
      };
}
