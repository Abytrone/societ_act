// To parse this JSON data, do
//
//     final network = networkFromJson(jsonString);

import 'dart:convert';

Network networkFromJson(String str) => Network.fromJson(json.decode(str));

String networkToJson(Network data) => json.encode(data.toJson());

class Network {
  Network({
    required this.data,
  });

  List<NData> data;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        data: List<NData>.from(json["data"].map((x) => NData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NData {
  NData({
    required this.id,
    required this.type,
    required this.attributes,
  });

  String id;
  String type;
  Attributes attributes;

  factory NData.fromJson(Map<String, dynamic> json) => NData(
        id: json["id"],
        type: json["type"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    required this.username,
    required this.fullname,
    required this.gender,
    required this.affiliatedWith,
    required this.userType,
    required this.userGroup,
    required this.email,
    required this.picture,
    required this.followers,
    required this.following,
    required this.cases,
  });

  String username;
  String fullname;
  String gender;
  String affiliatedWith;
  String userType;
  int? userGroup;
  String email;
  String picture;
  int followers;
  int following;
  int cases;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        username: json["username"],
        fullname: json["fullname"],
        gender: json["gender"],
        affiliatedWith: json["affiliated_with"],
        userType: json["user_type"],
        userGroup: json["user_group"],
        email: json["email"],
        picture: json["picture"] ?? 'null',
        followers: json["followers"],
        following: json["following"],
        cases: json["cases"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "fullname": fullname,
        "gender": gender,
        "affiliated_with": affiliatedWith,
        "user_type": userType,
        "user_group": userGroup,
        "email": email,
        "picture": picture == 'null' ? 'null' : picture,
        "followers": followers,
        "following": following,
        "cases": cases,
      };
}
