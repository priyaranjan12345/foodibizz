import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrderDetailsResponse {
  final List<AllSoldItem> allSoldItems;
  OrderDetailsResponse({
    required this.allSoldItems,
  });

  OrderDetailsResponse copyWith({
    List<AllSoldItem>? allSoldItems,
  }) {
    return OrderDetailsResponse(
      allSoldItems: allSoldItems ?? this.allSoldItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allSoldItems': allSoldItems.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetailsResponse.fromMap(Map<String, dynamic> map) {
    return OrderDetailsResponse(
      allSoldItems: List<AllSoldItem>.from(map['allSoldItems']?.map((x) => AllSoldItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsResponse.fromJson(String source) => OrderDetailsResponse.fromMap(json.decode(source));

  @override
  String toString() => 'OrderDetailsResponse(allSoldItems: $allSoldItems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderDetailsResponse &&
      listEquals(other.allSoldItems, allSoldItems);
  }

  @override
  int get hashCode => allSoldItems.hashCode;
}

class AllSoldItem {
  final String name;
  final String image;
  final int orderId;
  final int itemId;
  final int itemQty;
  final double price;
  final double totalAmount;
  AllSoldItem({
    required this.name,
    required this.image,
    required this.orderId,
    required this.itemId,
    required this.itemQty,
    required this.price,
    required this.totalAmount,
  });

  AllSoldItem copyWith({
    String? name,
    String? image,
    int? orderId,
    int? itemId,
    int? itemQty,
    double? price,
    double? totalAmount,
  }) {
    return AllSoldItem(
      name: name ?? this.name,
      image: image ?? this.image,
      orderId: orderId ?? this.orderId,
      itemId: itemId ?? this.itemId,
      itemQty: itemQty ?? this.itemQty,
      price: price ?? this.price,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'orderId': orderId,
      'itemId': itemId,
      'itemQty': itemQty,
      'price': price,
      'totalAmount': totalAmount,
    };
  }

  factory AllSoldItem.fromMap(Map<String, dynamic> map) {
    return AllSoldItem(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      orderId: map['orderId']?.toInt() ?? 0,
      itemId: map['itemId']?.toInt() ?? 0,
      itemQty: map['itemQty']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllSoldItem.fromJson(String source) => AllSoldItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AllSoldItem(name: $name, image: $image, orderId: $orderId, itemId: $itemId, itemQty: $itemQty, price: $price, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AllSoldItem &&
      other.name == name &&
      other.image == image &&
      other.orderId == orderId &&
      other.itemId == itemId &&
      other.itemQty == itemQty &&
      other.price == price &&
      other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      image.hashCode ^
      orderId.hashCode ^
      itemId.hashCode ^
      itemQty.hashCode ^
      price.hashCode ^
      totalAmount.hashCode;
  }
}