// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.data,
  });

  List<Datum> data;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.type,
    required this.attributes,
  });

  String id;
  String type;
  Attributes attributes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    required this.commentsCount,
    required this.comments,
    required this.isAdopted,
    required this.createdAt,
  });

  String title;
  String slug;
  String description;
  String picture;
  PostedBy postedBy;
  String category;
  String location;
  int likes;
  int commentsCount;
  List<Comment> comments;
  int isAdopted;
  DateTime createdAt;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        picture: json["picture"],
        postedBy: PostedBy.fromJson(json["posted_by"]),
        category: json["category"],
        location: json["location"],
        likes: json["likes"],
        commentsCount: json["comments_count"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        isAdopted: json["is_adopted"],
        createdAt: DateTime.parse(json["created_at"]),
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
        "comments_count": commentsCount,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "is_adopted": isAdopted,
        "created_at": createdAt.toIso8601String(),
      };
}

class Comment {
  Comment({
    required this.userId,
    required this.comment,
    required this.message,
    required this.createdAt,
    required this.user,
  });

  int? userId;
  String? comment;
  String? message;
  DateTime? createdAt;
  List<PostUser>? user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId: json["user_id"],
        comment: json["comment"],
        message: json["comment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        user: json["user"] == null
            ? null
            : List<PostUser>.from(
                json["user"].map((x) => PostUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "comment": comment,
        "created_at": createdAt!.toIso8601String(),
        "user": List<dynamic>.from(user!.map((x) => x.toJson())),
      };
}

class PostUser {
  PostUser({
    required this.fullname,
    required this.username,
    required this.picture,
  });

  String? fullname;
  String? username;
  String? picture;

  factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
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

class PostedBy {
  PostedBy({
    required this.username,
    required this.fullname,
    required this.picture,
    required this.createdAt,
  });

  String username;
  String fullname;
  String? picture;
  DateTime createdAt;

  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
        username: json["username"],
        fullname: json["fullname"],
        picture: json["picture"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "fullname": fullname,
        "picture": picture,
        "created_at": createdAt.toIso8601String(),
      };
}
