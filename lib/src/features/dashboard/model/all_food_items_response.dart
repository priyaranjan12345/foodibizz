import 'dart:convert';

import 'package:flutter/foundation.dart';

class AllFoodItemResponse {
  final List<FoodItem> foodItems;
  AllFoodItemResponse({
    required this.foodItems,
  });

  AllFoodItemResponse copyWith({
    List<FoodItem>? foodItems,
  }) {
    return AllFoodItemResponse(
      foodItems: foodItems ?? this.foodItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foodItems': foodItems.map((x) => x.toMap()).toList(),
    };
  }

  factory AllFoodItemResponse.fromMap(Map<String, dynamic> map) {
    return AllFoodItemResponse(
      foodItems: List<FoodItem>.from(
          map['foodItems']?.map((x) => FoodItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllFoodItemResponse.fromJson(String source) =>
      AllFoodItemResponse.fromMap(json.decode(source));

  @override
  String toString() => 'AllFoodItemResponse(foodItems: $foodItems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllFoodItemResponse &&
        listEquals(other.foodItems, foodItems);
  }

  @override
  int get hashCode => foodItems.hashCode;
}

class FoodItem {
  final String desc;
  final int id;
  final String image;
  final String creationDate;
  final String name;
  final int price;
  final String lastModifiedDate;
  FoodItem({
    required this.desc,
    required this.id,
    required this.image,
    required this.creationDate,
    required this.name,
    required this.price,
    required this.lastModifiedDate,
  });

  FoodItem copyWith({
    String? desc,
    int? id,
    String? image,
    String? creationDate,
    String? name,
    int? price,
    String? lastModifiedDate,
  }) {
    return FoodItem(
      desc: desc ?? this.desc,
      id: id ?? this.id,
      image: image ?? this.image,
      creationDate: creationDate ?? this.creationDate,
      name: name ?? this.name,
      price: price ?? this.price,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'id': id,
      'image': image,
      'creationDate': creationDate,
      'name': name,
      'price': price,
      'lastModifiedDate': lastModifiedDate,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      desc: map['desc'] ?? '',
      id: map['id']?.toInt() ?? 0,
      image: map['image'] ?? '',
      creationDate: map['creationDate'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toInt() ?? 0,
      lastModifiedDate: map['lastModifiedDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodItem.fromJson(String source) =>
      FoodItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FoodItem(desc: $desc, id: $id, image: $image, creationDate: $creationDate, name: $name, price: $price, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoodItem &&
        other.desc == desc &&
        other.id == id &&
        other.image == image &&
        other.creationDate == creationDate &&
        other.name == name &&
        other.price == price &&
        other.lastModifiedDate == lastModifiedDate;
  }

  @override
  int get hashCode {
    return desc.hashCode ^
        id.hashCode ^
        image.hashCode ^
        creationDate.hashCode ^
        name.hashCode ^
        price.hashCode ^
        lastModifiedDate.hashCode;
  }
}
