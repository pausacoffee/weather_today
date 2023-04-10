import 'package:intl/intl.dart';

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
