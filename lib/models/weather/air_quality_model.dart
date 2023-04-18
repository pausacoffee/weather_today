import 'package:meta/meta.dart';
import 'dart:convert';

///공기질 데이터 (aqi = yes)
class AirQualityModel {
  AirQualityModel(
      {required this.co,
      required this.no2,
      required this.o3,
      required this.so2,
      required this.pm25,
      required this.pm10,
      required this.usEpaIndex,
      required this.gbDefraIndex});

  /// Carbon Monoxide (μg/m3)
  double co;

  /// Ozone (μg/m3)
  double no2;

  /// Nitrogen dioxide (μg/m3)
  double o3;

  /// Sulphur dioxide (μg/m3)
  double so2;

  /// PM2.5 (μg/m3)
  double pm25;

  /// PM10 (μg/m3)
  double pm10;

  /// US - EPA standard.
  /// 1 means Good
  /// 2 means Moderate
  /// 3 means Unhealthy for sensitive group
  /// 4 means Unhealthy
  /// 5 means Very Unhealthy
  /// 6 means Hazardous
  int usEpaIndex;

  /// UK Defra Index (See table below)
  /// Index	|1	|2	|3	|4	|5	|6	|7	|8	|9	|10
  /// Band	|Low	|Low	|Low	|Moderate	|Moderate	|Moderate	|High	|High	|High	|Very High
  /// µgm-3	|0-11	|12-23	|24-35	|36-41	|42-47	|48-53	|54-58	|59-64	|65-70	|71 or more
  int gbDefraIndex;

  factory AirQualityModel.fromJson(Map<String, dynamic> json) =>
      AirQualityModel(
        co: json['co'] ?? 0.0,
        no2: json['no2'] ?? 0.0,
        o3: json['o3'] ?? 0.0,
        so2: json['so2'] ?? 0.0,
        pm25: json['pm2_5'] ?? 0.0,
        pm10: json['pm10'] ?? 0.0,
        usEpaIndex: json['us-epa-index'] ?? 0,
        gbDefraIndex: json['gb-defra-index'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'co': co,
        'no2': no2,
        'o3': o3,
        'so2': so2,
        'pm2_5': pm25,
        'pm10': pm10,
        'us-epa-index': usEpaIndex,
        'gb-defra-index': gbDefraIndex,
      };
}
