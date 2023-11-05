import 'dart:convert';

import 'package:flutter/foundation.dart';

class Cart {
  final List<CartItem> cartItems;
  Cart({
    required this.cartItems,
  });

  Cart copyWith({
    List<CartItem>? cartItems,
  }) {
    return Cart(
      cartItems: cartItems ?? this.cartItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      cartItems: List<CartItem>.from(
          map['cartItems']?.map((x) => CartItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(cartItems: $cartItems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart && listEquals(other.cartItems, cartItems);
  }

  @override
  int get hashCode => cartItems.hashCode;
}

class CartItem {
  final String desc;
  final int id;
  final String image;
  final String creationDate;
  final String name;
  final double price;
  final String lastModifiedDate;
  final int qty;
  CartItem({
    required this.desc,
    required this.id,
    required this.image,
    required this.creationDate,
    required this.name,
    required this.price,
    required this.lastModifiedDate,
    required this.qty,
  });

  CartItem copyWith({
    String? desc,
    int? id,
    String? image,
    String? creationDate,
    String? name,
    double? price,
    String? lastModifiedDate,
    int? qty,
  }) {
    return CartItem(
      desc: desc ?? this.desc,
      id: id ?? this.id,
      image: image ?? this.image,
      creationDate: creationDate ?? this.creationDate,
      name: name ?? this.name,
      price: price ?? this.price,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      qty: qty ?? this.qty,
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
      'qty': qty,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      desc: map['desc'] ?? '',
      id: map['id']?.toInt() ?? 0,
      image: map['image'] ?? '',
      creationDate: map['creationDate'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      lastModifiedDate: map['lastModifiedDate'] ?? '',
      qty: map['qty']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartItem(desc: $desc, id: $id, image: $image, creationDate: $creationDate, name: $name, price: $price, lastModifiedDate: $lastModifiedDate, qty: $qty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.desc == desc &&
        other.id == id &&
        other.image == image &&
        other.creationDate == creationDate &&
        other.name == name &&
        other.price == price &&
        other.lastModifiedDate == lastModifiedDate &&
        other.qty == qty;
  }

  @override
  int get hashCode {
    return desc.hashCode ^
        id.hashCode ^
        image.hashCode ^
        creationDate.hashCode ^
        name.hashCode ^
        price.hashCode ^
        lastModifiedDate.hashCode ^
        qty.hashCode;
  }
}
