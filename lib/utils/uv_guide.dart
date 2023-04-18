import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///[https://www.weatheri.co.kr/forecast/forecast09.php] 참고

///uv 지수에 따른 색상
Color getUvColor(double uv) {
  Color color = Colors.white;

  if (uv <= 2) {
    color = Colors.green;
  } else if (uv <= 5) {
    color = Colors.orange;
  } else if (uv <= 7) {
    color = Colors.yellow;
  } else if (uv <= 10) {
    color = Colors.red;
  } else {
    color = Colors.purple;
  }

  return color;
}

///uv 지수에 따른 레벨
String getUvLevel(double uv) {
  String result = '';

  if (uv <= 2) {
    result = '낮음';
  } else if (uv <= 5) {
    result = '보통';
  } else if (uv <= 7) {
    result = '높음';
  } else if (uv <= 10) {
    result = '매우 높음';
  } else {
    result = '위험';
  }

  return result;
}

///uv 지수에 따른 안내 문구
String getUvMsg(double uv) {
  String result = '';
  if (uv <= 2) {
    result = '자외선 복사로 인한 위험이 적어요. 하지만 민감하신 분들은 꼭 자외선 차단제를 챙기세요.';
  } else if (uv <= 5) {
    result = '자외선 차단제와 외투를 준비해 주세요.';
  } else if (uv <= 7) {
    result = '태양에 오래 노출되면 위험해요! 자외선 차단제와 외투, 선글라스를 준비해 주세요.';
  } else if (uv <= 10) {
    result =
        '강한 자외선에 피부가 빠르게 탈 수 있어요! 실내나 그늘에 머물러야 해요. 자외선 차단제와 외투 선글라스를 준비해 주세요.';
  } else {
    result = '수십분만 노출되어도 매우 위험해요! 자외선 차단제를 2시간마다 발라주세요.';
  }

  return result;
}
