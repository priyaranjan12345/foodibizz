import 'dart:convert';

import 'package:flutter/foundation.dart';

class AllOrders {
  final List<AllOrder> allOrders;
  AllOrders({
    required this.allOrders,
  });

  AllOrders copyWith({
    List<AllOrder>? allOrders,
  }) {
    return AllOrders(
      allOrders: allOrders ?? this.allOrders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allOrders': allOrders.map((x) => x.toMap()).toList(),
    };
  }

  factory AllOrders.fromMap(Map<String, dynamic> map) {
    return AllOrders(
      allOrders: List<AllOrder>.from(map['allOrders']?.map((x) => AllOrder.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllOrders.fromJson(String source) => AllOrders.fromMap(json.decode(source));

  @override
  String toString() => 'AllOrders(allOrders: $allOrders)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AllOrders &&
      listEquals(other.allOrders, allOrders);
  }

  @override
  int get hashCode => allOrders.hashCode;
}

class AllOrder {
  final int discount;
  final int id;
  final String invNum;
  final int grandTotal;
  final int noOfItems;
  final String billingDate;
  final int gst;
  AllOrder({
    required this.discount,
    required this.id,
    required this.invNum,
    required this.grandTotal,
    required this.noOfItems,
    required this.billingDate,
    required this.gst,
  });

  AllOrder copyWith({
    int? discount,
    int? id,
    String? invNum,
    int? grandTotal,
    int? noOfItems,
    String? billingDate,
    int? gst,
  }) {
    return AllOrder(
      discount: discount ?? this.discount,
      id: id ?? this.id,
      invNum: invNum ?? this.invNum,
      grandTotal: grandTotal ?? this.grandTotal,
      noOfItems: noOfItems ?? this.noOfItems,
      billingDate: billingDate ?? this.billingDate,
      gst: gst ?? this.gst,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'discount': discount,
      'id': id,
      'invNum': invNum,
      'grandTotal': grandTotal,
      'noOfItems': noOfItems,
      'billingDate': billingDate,
      'gst': gst,
    };
  }

  factory AllOrder.fromMap(Map<String, dynamic> map) {
    return AllOrder(
      discount: map['discount']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      invNum: map['invNum'] ?? '',
      grandTotal: map['grandTotal']?.toInt() ?? 0,
      noOfItems: map['noOfItems']?.toInt() ?? 0,
      billingDate: map['billingDate'] ?? '',
      gst: map['gst']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllOrder.fromJson(String source) => AllOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AllOrder(discount: $discount, id: $id, invNum: $invNum, grandTotal: $grandTotal, noOfItems: $noOfItems, billingDate: $billingDate, gst: $gst)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AllOrder &&
      other.discount == discount &&
      other.id == id &&
      other.invNum == invNum &&
      other.grandTotal == grandTotal &&
      other.noOfItems == noOfItems &&
      other.billingDate == billingDate &&
      other.gst == gst;
  }

  @override
  int get hashCode {
    return discount.hashCode ^
      id.hashCode ^
      invNum.hashCode ^
      grandTotal.hashCode ^
      noOfItems.hashCode ^
      billingDate.hashCode ^
      gst.hashCode;
  }
}