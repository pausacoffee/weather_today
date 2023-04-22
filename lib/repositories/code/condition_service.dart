import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

import '../../models/code/condition_code_model.dart';
import '../../models/code/language_model.dart';

/// condition 에 대한 code data 관리
class ConditionRepository {
  // Singleton ▼ ========================================
  static final ConditionRepository _singleton = ConditionRepository._();

  /// condition에 대한 code data 관리
  factory ConditionRepository() {
    return _singleton;
  }

  ConditionRepository._();
  // Variable ▼ ========================================

  /// condition 에 대한 code data list
  List<ConditionCodeModel> codeList = [];

  // Function ▼ ========================================
  ///초기화
  void init() {
    try {
      readJson();
    } catch (e) {
      Logger().d(e);
    }
  }

  /// json 파일에서 data 읽기
  Future<void> readJson() async {
    try {
      String response =
          await rootBundle.loadString('assets/data/condition_code.json');
      final data = await json.decode(response);

      codeList.addAll(List<ConditionCodeModel>.from(
          (data.map((e) => ConditionCodeModel.fromJson(e)))));
    } catch (e) {
      Logger().d(e);
    }
  }

  /// 낮 날씨
  String dayText(int code) {
    String result = "";

    if (codeList.isEmpty) return result;

    try {
      ConditionCodeModel condition = codeList.firstWhere(
        (condition) => condition.code == code,
        orElse: () => ConditionCodeModel(
            code: -1, day: '', icon: -1, languages: [], night: ''),
      );

      LanguageModel lan = condition.languages.firstWhere(
        (lan) =>
            lan.langIso ==
            'ko', //TODO:  //Localizations.localeOf(context).languageCode

        orElse: () => LanguageModel(
            dayText: '', langIso: '', langName: '', nightText: ''),
      );

      result = lan.dayText;
    } catch (e) {
      Logger().d(e.toString());
    }

    return result;
  }

  /// 밤 날씨
  String nightText(int code) {
    String result = "";

    if (codeList.isEmpty) return result;

    try {
      ConditionCodeModel condition = codeList.firstWhere(
        (condition) => condition.code == code,
        orElse: () => ConditionCodeModel(
            code: -1, day: '', icon: -1, languages: [], night: ''),
      );

      LanguageModel lan = condition.languages.firstWhere(
        (lan) => lan.langIso == 'ko', //TODO: scale에 따라 언어 바꾸기
        orElse: () => LanguageModel(
            dayText: '', langIso: '', langName: '', nightText: ''),
      );

      result = lan.nightText;
    } catch (e) {
      Logger().d(e.toString());
    }

    return result;
  }

  ///text
  /// isDay : 1 = Yes, 0 = No
  String text({required int code, required int isDay}) {
    String result = "";
    try {
      switch (isDay) {
        case 0:
          result = dayText(code);
          break;
        case 1:
          result = nightText(code);
          break;
        default:
          result = dayText(code);
          break;
      }
    } catch (e) {
      Logger().d(e);
    }
    return result;
  }

  /// icon code
  /// isDay : 1 = Yes, 0 = No
  String iconPath({required int code, required int isDay}) {
    String dayPath;
    switch (isDay) {
      case 0:
        dayPath = 'day';
        break;
      case 1:
        dayPath = 'night';
        break;
      default:
        dayPath = 'day';
        break;
    }

    String result = 'assets/$dayPath/113.png';

    if (codeList.isEmpty) return result;

    try {
      ConditionCodeModel condition = codeList.firstWhere(
        (condition) => condition.code == code,
        orElse: () => ConditionCodeModel(
            code: -1, day: '', icon: -1, languages: [], night: ''),
      );

      if (condition.icon == -1) return result;

      result = 'assets/$dayPath/${condition.icon}.png';
    } catch (e) {
      Logger().d(e.toString());
    }

    return result;
  }
}
