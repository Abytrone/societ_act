// To parse this JSON data, do
//
//     final notify = notifyFromJson(jsonString);

import 'dart:convert';

List<Notify> notifyFromJson(String str) =>
    List<Notify>.from(json.decode(str).map((x) => Notify.fromJson(x)));

String notifyToJson(List<Notify> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notify {
  Notify({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String type;
  final String notifiableType;
  final int notifiableId;
  final Data data;
  final dynamic readAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        data: Data.fromJson(json["data"]),
        readAt: json["read_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "data": data.toJson(),
        "read_at": readAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Data {
  Data({
    required this.username,
    required this.userId,
    required this.caseCommentedOn,
    required this.message,
    required this.caseLiked,
    required this.caseAdopted,
  });

  final String? username;
  final int? userId;
  final int? caseCommentedOn;
  final String? message;
  final int? caseLiked;
  final int? caseAdopted;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        userId: json["user_id"],
        caseCommentedOn: json["case_commented_on"],
        message: json["message"],
        caseLiked: json["case_liked"],
        caseAdopted: json["case_adopted"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "user_id": userId,
        "case_commented_on": caseCommentedOn,
        "message": message,
        "case_liked": caseLiked,
        "case_adopted": caseAdopted,
      };
}
