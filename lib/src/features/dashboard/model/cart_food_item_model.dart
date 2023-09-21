import 'package:hive_flutter/hive_flutter.dart';

part 'cart_food_item_model.g.dart';

@HiveType(typeId: 0)
class CartFoodItemModel extends HiveObject {
  @HiveField(0)
  late String desc;

  @HiveField(1)
  late int id;

  @HiveField(2)
  late String image;

  @HiveField(3)
  late String creationDate;

  @HiveField(4)
  late String name;

  @HiveField(5)
  late int price;

  @HiveField(6)
  late String lastModifiedDate;
}
