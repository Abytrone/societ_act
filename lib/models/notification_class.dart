// To parse this JSON data, do
//
//     final network = networkFromJson(jsonString);

import 'dart:convert';

List<Notification> notificationFromJson(String str) => List<Notification>.from(
    json.decode(str).map((x) => Notification.fromJson(x)));

String notificationToJson(List<Notification> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notification {
  Notification({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  Type type;
  String notifiableType;
  int notifiableId;
  Data data;
  dynamic readAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
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
    required this.caseLiked,
    required this.message,
    required this.caseAdopted,
  });

  String username;
  int userId;
  int caseLiked;
  String message;
  int caseAdopted;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        userId: json["user_id"],
        caseLiked: json["case_liked"],
        message: json["message"],
        caseAdopted: json["case_adopted"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "user_id": userId,
        "case_liked": caseLiked,
        "message": message,
        "case_adopted": caseAdopted,
      };
}
