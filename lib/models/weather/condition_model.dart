// To parse this JSON data, do
//
//     final conditionModel = conditionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ConditionModel conditionModelFromJson(String str) =>
    ConditionModel.fromJson(json.decode(str));

String conditionModelToJson(ConditionModel data) => json.encode(data.toJson());

class ConditionModel {
  ConditionModel({
    required this.text,
    required this.icon,
    required this.code,
  });

  String text;
  String icon;
  int code;

  factory ConditionModel.fromJson(Map<String, dynamic> json) => ConditionModel(
        text: json["text"] ?? '',
        icon: json["icon"] ?? '',
        code: json["code"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}
