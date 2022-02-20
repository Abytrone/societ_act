// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
  Error({
    required this.message,
    // required this.errors,
  });

  String message;
  // Errors errors;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        // errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        // "errors": errors.toJson(),
      };
}
