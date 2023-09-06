import 'dart:convert';

class AddRecipeResponseModel {
  final String desc;
  final int id;
  final String image;
  final String creationDate;
  final String name;
  final int price;
  final String lastModifiedDate;
  AddRecipeResponseModel({
    required this.desc,
    required this.id,
    required this.image,
    required this.creationDate,
    required this.name,
    required this.price,
    required this.lastModifiedDate,
  });

  AddRecipeResponseModel copyWith({
    String? desc,
    int? id,
    String? image,
    String? creationDate,
    String? name,
    int? price,
    String? lastModifiedDate,
  }) {
    return AddRecipeResponseModel(
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
    return <String, dynamic>{
      'desc': desc,
      'id': id,
      'image': image,
      'creationDate': creationDate,
      'name': name,
      'price': price,
      'lastModifiedDate': lastModifiedDate,
    };
  }

  factory AddRecipeResponseModel.fromMap(Map<String, dynamic> map) {
    return AddRecipeResponseModel(
      desc: map['desc'] as String,
      id: map['id'].toInt() as int,
      image: map['image'] as String,
      creationDate: map['creationDate'] as String,
      name: map['name'] as String,
      price: map['price'].toInt() as int,
      lastModifiedDate: map['lastModifiedDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddRecipeResponseModel.fromJson(String source) =>
      AddRecipeResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddRecipeResponseModel(desc: $desc, id: $id, image: $image, creationDate: $creationDate, name: $name, price: $price, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(covariant AddRecipeResponseModel other) {
    if (identical(this, other)) return true;

    return other.desc == desc &&
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
