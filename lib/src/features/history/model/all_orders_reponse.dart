import 'dart:convert';

import 'package:flutter/foundation.dart';

class AllOrdersResponse {
  final List<AllOrder> allOrders;
  AllOrdersResponse({
    required this.allOrders,
  });

  AllOrdersResponse copyWith({
    List<AllOrder>? allOrders,
  }) {
    return AllOrdersResponse(
      allOrders: allOrders ?? this.allOrders,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allOrders': allOrders.map((x) => x.toMap()).toList(),
    };
  }

  factory AllOrdersResponse.fromMap(Map<String, dynamic> map) {
    return AllOrdersResponse(
      allOrders: List<AllOrder>.from(
        (map['allOrders'] as List<int>).map<AllOrder>(
          (x) => AllOrder.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllOrdersResponse.fromJson(String source) =>
      AllOrdersResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AllOrdersResponse(allOrders: $allOrders)';

  @override
  bool operator ==(covariant AllOrdersResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.allOrders, allOrders);
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
    return <String, dynamic>{
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
      discount: map['discount'].toInt() as int,
      id: map['id'].toInt() as int,
      invNum: map['invNum'] as String,
      grandTotal: map['grandTotal'].toInt() as int,
      noOfItems: map['noOfItems'].toInt() as int,
      billingDate: map['billingDate'] as String,
      gst: map['gst'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllOrder.fromJson(String source) =>
      AllOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AllOrder(discount: $discount, id: $id, invNum: $invNum, grandTotal: $grandTotal, noOfItems: $noOfItems, billingDate: $billingDate, gst: $gst)';
  }

  @override
  bool operator ==(covariant AllOrder other) {
    if (identical(this, other)) return true;

    return other.discount == discount &&
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
