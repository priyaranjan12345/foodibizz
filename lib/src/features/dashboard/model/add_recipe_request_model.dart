// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'dart:io';

// class AddRecipeRequestModel {
//   final String name;
//   final String desc;
//   final double price;
//   final File img;
//   AddRecipeRequestModel({
//     required this.name,
//     required this.desc,
//     required this.price,
//     required this.img,
//   });


//   AddRecipeRequestModel copyWith({
//     String? name,
//     String? desc,
//     double? price,
//     File? img,
//   }) {
//     return AddRecipeRequestModel(
//       name: name ?? this.name,
//       desc: desc ?? this.desc,
//       price: price ?? this.price,
//       img: img ?? this.img,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'desc': desc,
//       'price': price,
//       'img': img.toMap(),
//     };
//   }

//   factory AddRecipeRequestModel.fromMap(Map<String, dynamic> map) {
//     return AddRecipeRequestModel(
//       name: map['name'] as String,
//       desc: map['desc'] as String,
//       price: map['price'] as double,
//       img: File.fromMap(map['img'] as Map<String,dynamic>),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory AddRecipeRequestModel.fromJson(String source) => AddRecipeRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'AddRecipeRequestModel(name: $name, desc: $desc, price: $price, img: $img)';
//   }

//   @override
//   bool operator ==(covariant AddRecipeRequestModel other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.name == name &&
//       other.desc == desc &&
//       other.price == price &&
//       other.img == img;
//   }

//   @override
//   int get hashCode {
//     return name.hashCode ^
//       desc.hashCode ^
//       price.hashCode ^
//       img.hashCode;
//   }
// }
