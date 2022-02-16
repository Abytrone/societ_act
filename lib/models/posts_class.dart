// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    this.id,
    this.title,
    this.userId,
    this.content,
    this.likes,
    this.hits,
    this.categoryId,
    this.imageUrl,
  });

  int? id;
  String? title;
  int? userId;
  String? content;
  int? likes;
  int? hits;
  int? categoryId;
  String? imageUrl;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        userId: json["userId"],
        content: json["content"],
        likes: json["likes"],
        hits: json["hits"],
        categoryId: json["categoryId"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "userId": userId,
        "content": content,
        "likes": likes,
        "hits": hits,
        "categoryId": categoryId,
        "imageUrl": imageUrl,
      };
}



// class Post {
//   final String? fullname;
//   final String? username;
//   final String? userImage;
//   final String? postImage;
//   final String? postText;
//   final String? postTitle;
//   final String? likes;

//   const Post({
//     this.fullname,
//     this.username,
//     this.userImage,
//     this.postImage,
//     this.postText,
//     this.postTitle,
//     this.likes,
//   });
// }
