// To parse this JSON datum, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

// Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

// String categoryToJson(Category datum) => json.encode(datum.toJson());

// class Category {
//   Category({
//     required this.datum,
//   });

//   List<Datum> datum;

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         datum: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(datum.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   Datum({
//     required this.id,
//     required this.name,
//   });

//   int id;
//   String name;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }

// -----------------------------------------------------------------------------

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
    );
  }

  static List<Category> fromJsonList(List list) {
    return list.map((item) => Category.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString
  // bool userFilterByCreationDate(String filter) {
  //   return this?.createdAt?.toString()?.contains(filter);
  // }

  ///custom comparing function to check if two users are equal
  bool isEqual(Category model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
