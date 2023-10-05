import 'package:hive_flutter/hive_flutter.dart';

part 'cart_food_item_model.g.dart';

@HiveType(typeId: 0)
class CartFoodItemModel extends HiveObject {
  @HiveField(0)
  final String desc;

  @HiveField(1)
  final int id;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String creationDate;

  @HiveField(4)
  final String name;

  @HiveField(5)
  final double price;

  @HiveField(6)
  final String lastModifiedDate;

  @HiveField(7)
  final int qty;

  CartFoodItemModel({
    required this.desc,
    required this.id,
    required this.image,
    required this.creationDate,
    required this.name,
    required this.price,
    required this.lastModifiedDate,
    required this.qty,
  });

  CartFoodItemModel copyWith({
    String? desc,
    int? id,
    String? image,
    String? creationDate,
    String? name,
    double? price,
    String? lastModifiedDate,
    int? qty,
  }) {
    return CartFoodItemModel(
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
}
