// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_food_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartFoodItemModelAdapter extends TypeAdapter<CartFoodItemModel> {
  @override
  final int typeId = 0;

  @override
  CartFoodItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartFoodItemModel(
      desc: fields[0] as String,
      id: fields[1] as int,
      image: fields[2] as String,
      creationDate: fields[3] as String,
      name: fields[4] as String,
      price: fields[5] as double,
      lastModifiedDate: fields[6] as String,
      qty: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartFoodItemModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.desc)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.creationDate)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.lastModifiedDate)
      ..writeByte(7)
      ..write(obj.qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartFoodItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
