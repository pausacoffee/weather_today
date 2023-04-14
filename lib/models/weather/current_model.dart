// To parse this JSON data, do
//
//     final currentModel = currentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'condition_model.dart';

CurrentModel currentModelFromJson(String str) =>
    CurrentModel.fromJson(json.decode(str));

String currentModelToJson(CurrentModel data) => json.encode(data.toJson());

class CurrentModel {
  CurrentModel({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  /// Local time when the real time data was updated in unix time.
  int lastUpdatedEpoch;

  /// Local time when the real time data was updated.
  DateTime lastUpdated;

  /// Temperature in celsius
  double tempC;

  /// Temperature in fahrenheit
  double tempF;

  /// [1 = Yes 0 = No] Whether to show day condition icon or night icon
  int isDay;

  ///
  ConditionModel condition;

  /// Wind speed in miles per hour
  double windMph;

  /// Wind speed in kilometer per hour
  double windKph;

  /// Wind direction in degrees
  int windDegree;

  /// Wind direction as 16 point compass. e.g.: NSW
  String windDir;

  /// Pressure in millibars
  double pressureMb;

  /// Pressure in inches
  double pressureIn;

  /// Precipitation amount in millimeters
  double precipMm;

  /// Precipitation amount in inches
  double precipIn;

  /// Humidity as percentage
  int humidity;

  /// Cloud cover as percentage
  int cloud;

  /// Feels like temperature in celsius
  double feelslikeC;

  /// Feels like temperature in fahrenheit
  double feelslikeF;

  /// Visibility in kilometer
  double visKm;

  /// Visibility in miles
  double visMiles;

  /// UV Index
  double uv;

  /// Wind gust in miles per hour
  double gustMph;

  /// Wind gust in kilometer per hour
  double gustKph;

  factory CurrentModel.fromJson(Map<String, dynamic> json) => CurrentModel(
        lastUpdatedEpoch: json["last_updated_epoch"] ?? -1,
        lastUpdated: json["last_updated"] != null
            ? DateTime.parse(json["last_updated"])
            : DateTime.parse('0000-00-00 00:00'),
        tempC: json["temp_c"] != null ? json["temp_c"].toDouble() : -1.0,
        tempF: json["temp_f"] != null ? json["temp_f"].toDouble() : -1.0,
        isDay: json["is_day"] ?? -1, //1 = Yes 0 = No
        condition: ConditionModel.fromJson(json["condition"]),
        windMph: json["wind_mph"] != null ? json["wind_mph"].toDouble() : -1.0,
        windKph: json["wind_kph"] != null ? json["wind_kph"].toDouble() : -1.0,
        windDegree: json["wind_degree"] ?? -1,
        windDir: json["wind_dir"] ?? '',
        pressureMb:
            json["pressure_mb"] != null ? json["pressure_mb"].toDouble() : -1.0,
        pressureIn:
            json["pressure_in"] != null ? json["pressure_in"].toDouble() : -1.0,
        precipMm:
            json["precip_mm"] != null ? json["precip_mm"].toDouble() : -1.0,
        precipIn:
            json["precip_in"] != null ? json["precip_in"].toDouble() : -1.0,
        humidity: json["humidity"],
        cloud: json["cloud"],
        feelslikeC:
            json["feelslike_c"] != null ? json["feelslike_c"].toDouble() : -1.0,
        feelslikeF:
            json["feelslike_f"] != null ? json["feelslike_f"].toDouble() : -1.0,
        visKm: json["vis_km"] != null ? json["vis_km"].toDouble() : -1.0,
        visMiles:
            json["vis_miles"] != null ? json["vis_miles"].toDouble() : -1.0,
        uv: json["uv"] != null ? json["uv"].toDouble() : -1.0,
        gustMph: json["gust_mph"] != null ? json["gust_mph"].toDouble() : -1.0,
        gustKph: json["gust_kph"] != null ? json["gust_kph"].toDouble() : -1.0,
      );

  Map<String, dynamic> toJson() => {
        "last_updated_epoch": lastUpdatedEpoch,
        "last_updated": lastUpdated,
        "temp_c": tempC,
        "temp_f": tempF,
        "is_day": isDay,
        "condition": condition.toJson(),
        "wind_mph": windMph,
        "wind_kph": windKph,
        "wind_degree": windDegree,
        "wind_dir": windDir,
        "pressure_mb": pressureMb,
        "pressure_in": pressureIn,
        "precip_mm": precipMm,
        "precip_in": precipIn,
        "humidity": humidity,
        "cloud": cloud,
        "feelslike_c": feelslikeC,
        "feelslike_f": feelslikeF,
        "vis_km": visKm,
        "vis_miles": visMiles,
        "uv": uv,
        "gust_mph": gustMph,
        "gust_kph": gustKph,
      };
}
