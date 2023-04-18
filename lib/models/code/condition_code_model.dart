import 'package:weather_today/models/code/language_model.dart';

/// condition code 정의 model
/// api 의 condition과 code로 매칭하여 icon, lan 을 가져온다.
class ConditionCodeModel {
  ConditionCodeModel({
    required this.code,
    required this.day,
    required this.night,
    required this.icon,
    required this.languages,
  });

  int code;
  String day;
  String night;
  int icon;
  List<LanguageModel> languages;

  factory ConditionCodeModel.fromJson(Map<String, dynamic> json) =>
      ConditionCodeModel(
        code: json["code"] ?? -1,
        day: json["day"] ?? '',
        night: json["night"] ?? '',
        icon: json["icon"] ?? -1,
        languages: List<LanguageModel>.from(
            json["languages"].map((x) => LanguageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "day": day,
        "night": night,
        "icon": icon,
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
      };
}
