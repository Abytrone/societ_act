// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.token,
    required this.status,
    required this.user,
  });

  String token;
  int status;
  UserClass user;

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        status: json["status"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "status": status,
        "user": user.toJson(),
      };
}

class UserClass {
  UserClass({
    required this.fullname,
    required this.username,
    required this.email,
    required this.gender,
    required this.userType,
    required this.affiliatedWith,
    required this.userGroup,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String fullname;
  String username;
  String email;
  String gender;
  String userType;
  String affiliatedWith;
  String userGroup;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        fullname: json["fullname"],
        username: json["username"],
        email: json["email"],
        gender: json["gender"],
        userType: json["user_type"],
        affiliatedWith: json["affiliated_with"],
        userGroup: json["user_group"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "username": username,
        "email": email,
        "gender": gender,
        "user_type": userType,
        "affiliated_with": affiliatedWith,
        "user_group": userGroup,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
