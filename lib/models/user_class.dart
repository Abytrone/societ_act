// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.token,
    required this.data,
  });

  final String token;
  final Data data;

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
    required this.picture,
    required this.group,
    required this.email,
    required this.verificationStatus,
    required this.followers,
    required this.following,
    required this.message,
  });

  final String? id;
  final String? type;
  final String? username;
  final String? fullname;
  final String? gender;
  final String? affiliatedWith;
  final String? userType;
  final String? picture;
  final String? group;
  final String? email;
  final String? verificationStatus;
  final String? followers;
  final String? following;
  final String? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        username: json["username"],
        fullname: json["fullname"],
        gender: json["gender"],
        affiliatedWith: json["affiliated_with"],
        userType: json["user_type"],
        picture: json["picture"],
        group: json["group"],
        email: json["email"],
        verificationStatus: json["verification_status"],
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
        "picture": picture,
        "group": group,
        "email": email,
        "verification_status": verificationStatus,
        "followers": followers,
        "following": following,
        "message": message,
      };
}
