import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// UI 표시 관련 ▼ ========================================

/// 숫자를 원단위로 표기
///
/// price : 가격
String parseNumberFormat(int price) {
  var t = NumberFormat('###,###,###,###원');
  return t.format(price);
}

/// 숫자를 콤마 단위로 표기
///
/// price : 가격
String parseNumberCommmaFormat(int num) {
  var t = NumberFormat('###,###,###,###');
  return t.format(num);
}

/// 초를 분:초로 나타내는 함수
///
/// [time] int : 초
String intToTimeString(time) {
  String min = "0${time ~/ 60}";
  String secode = time % 60 < 10 ? "0${time % 60}" : "${time % 60}";
  return "${min}:${secode}";
}

/// yyyy-MM-dd hh:mm 을 PM, AM 으로 바꾸어 주는 함수
String formatWeatherTime(String timeStr) {
  final hour = int.parse(timeStr.substring(11, 13));
  final amPm = hour >= 12 ? 'PM' : 'AM';
  final displayHour = hour % 12 == 0 ? 12 : hour % 12;
  return '$displayHour $amPm';
}

/// 영어로된 풍향 약어를 한국어로 바꾸어줌
String convertWindDirection(String direction) {
  switch (direction) {
    case 'N':
      return '북';
    case 'NNE':
      return '북북동';
    case 'NE':
      return '북동';
    case 'ENE':
      return '동북동';
    case 'E':
      return '동';
    case 'ESE':
      return '동남동';
    case 'SE':
      return '남동';
    case 'SSE':
      return '남남동';
    case 'S':
      return '남';
    case 'SSW':
      return '남남서';
    case 'SW':
      return '남서';
    case 'WSW':
      return '서남서';
    case 'W':
      return '서';
    case 'WNW':
      return '서북서';
    case 'NW':
      return '북서';
    case 'NNW':
      return '북북서';
    default:
      return '';
  }
}

// UV 관련 ▼ ========================================
//[https://www.weatheri.co.kr/forecast/forecast09.php] 참고

///uv 지수에 따른 색상
Color getUvColor(double uv) {
  Color color = Colors.white;

  if (uv <= 2) {
    color = Colors.green;
  } else if (uv <= 5) {
    color = Colors.yellow;
  } else if (uv <= 7) {
    color = Colors.orange;
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

//  ▼ ========================================
