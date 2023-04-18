///condition 에 대한 각 나라 언어별 data model
class LanguageModel {
  LanguageModel({
    required this.langName,
    required this.langIso,
    required this.dayText,
    required this.nightText,
  });

  String langName;
  String langIso;
  String dayText;
  String nightText;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        langName: json["lang_name"] ?? "",
        langIso: json["lang_iso"] ?? "",
        dayText: json["day_text"] ?? "",
        nightText: json["night_text"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "lang_name": langName,
        "lang_iso": langIso,
        "day_text": dayText,
        "night_text": nightText,
      };
}
