// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.token,
    required this.data,
  });

  String? token;
  Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.type,
    required this.username,
    required this.fullname,
    required this.gender,
    required this.affiliatedWith,
    required this.userType,
    required this.group,
    required this.email,
    required this.followers,
    required this.following,
    required this.message,
  });

  String? id;
  String? type;
  String? username;
  String? fullname;
  String? gender;
  String? affiliatedWith;
  String? userType;
  String? group;
  String? email;
  String? followers;
  String? following;
  String? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        username: json["username"],
        fullname: json["fullname"],
        gender: json["gender"],
        affiliatedWith: json["affiliated_with"],
        userType: json["user_type"],
        group: json["group"],
        email: json["email"],
        followers: json["followers"],
        following: json["following"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "username": username,
        "fullname": fullname,
        "gender": gender,
        "affiliated_with": affiliatedWith,
        "user_type": userType,
        "group": group,
        "email": email,
        "followers": followers,
        "following": following,
      };
}
