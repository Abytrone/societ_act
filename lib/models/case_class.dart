// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Case caseFromJson(String str) => Case.fromJson(json.decode(str));

String postToJson(Case data) => json.encode(data.toJson());

class Case {
  Case({
    required this.data,
  });

  List<Info> data;

  factory Case.fromJson(Map<String, dynamic> json) => Case(
        data: List<Info>.from(json["data"].map((x) => Info.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    required this.id,
    required this.type,
    required this.attributes,
  });

  String id;
  String type;
  Attributes attributes;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
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
    required this.title,
    required this.slug,
    required this.description,
    required this.picture,
    required this.postedBy,
    required this.category,
    required this.location,
    required this.likes,
    required this.like,
    required this.follow,
    required this.status,
    required this.commentsCount,
    required this.comments,
    required this.isAdopted,
    required this.createdAt,
  });

  String title;
  String slug;
  String description;
  String picture;
  CaseBy postedBy;
  String category;
  String location;
  String likes;
  String like;
  String follow;
  String status;
  String commentsCount;
  List<Comment> comments;
  String isAdopted;
  String createdAt;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        picture: json["picture"],
        postedBy: CaseBy.fromJson(json["posted_by"]),
        category: json["category"],
        location: json["location"],
        likes: json["likes"],
        like: json["has_liked"],
        follow: json["has_followed"],
        status: json["status"],
        commentsCount: json["comments_count"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        isAdopted: json["is_adopted"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "description": description,
        "picture": picture,
        "posted_by": postedBy.toJson(),
        "category": category,
        "location": location,
        "likes": likes,
        "has_liked": like,
        "has_followed": follow,
        "status": status,
        "comments_count": commentsCount,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "is_adopted": isAdopted,
        "created_at": createdAt,
      };
}

class Comment {
  Comment({
    required this.userId,
    required this.comment,
    required this.message,
    required this.createdAt,
    required this.postedAt,
    required this.following,
    required this.user,
  });

  int? userId;
  String? comment;
  String? message;
  DateTime? createdAt;
  String? postedAt;
  String? following;
  List<CaseUser>? user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId: json["user_id"],
        comment: json["comment"],
        message: json["comment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        postedAt: json["posted_at"],
        following: json["is_following"],
        user: json["user"] == null
            ? null
            : List<CaseUser>.from(
                json["user"].map((x) => CaseUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "comment": comment,
        "created_at": createdAt!.toIso8601String(),
        "posted_at": postedAt,
        "is_following": following,
        "user": List<dynamic>.from(user!.map((x) => x.toJson())),
      };
}

class CaseUser {
  CaseUser({
    required this.fullname,
    required this.username,
    required this.picture,
  });

  String? fullname;
  String? username;
  String? picture;

  factory CaseUser.fromJson(Map<String, dynamic> json) => CaseUser(
        fullname: json["fullname"],
        username: json["username"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "username": username,
        "picture": picture,
      };
}

class CaseBy {
  CaseBy({
    required this.username,
    required this.fullname,
    required this.picture,
    required this.createdAt,
  });

  String username;
  String fullname;
  String? picture;
  String createdAt;

  factory CaseBy.fromJson(Map<String, dynamic> json) => CaseBy(
        username: json["username"],
        fullname: json["fullname"],
        picture: json["picture"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "fullname": fullname,
        "picture": picture,
        "created_at": createdAt,
      };
}
