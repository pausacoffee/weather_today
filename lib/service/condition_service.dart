import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:weather_today/models/code/condition_code_model.dart';
import 'package:weather_today/models/code/language_model.dart';

/// condition 에 대한 code data 관리 service
class ConditionService {
  // Singleton ▼ ========================================
  static final ConditionService _singleton = ConditionService._internal();

  factory ConditionService() {
    return _singleton;
  }

  ConditionService._internal();
  // Variable ▼ ========================================

  /// condition 에 대한 code data list
  List<ConditionCodeModel> codeList = [];

  // Function ▼ ========================================

  void init() {
    try {
      readJson();
    } catch (e) {
      Logger().d(e);
    }
  }

  /// json 파일에서 읽기
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
        (lan) => lan.langIso == 'ko', //TODO: scale에 따라 언어 바꾸기
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
