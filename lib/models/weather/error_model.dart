// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    required this.code,
    required this.message,
  });

  /// Error code
  int code;

  /// Error message
  String message;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        code: json["code"] ?? -1,
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
