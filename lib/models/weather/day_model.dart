import 'package:meta/meta.dart';
import 'dart:convert';

import 'air_quality_model.dart';
import 'condition_model.dart';

class DayModel {
  DayModel({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.totalprecipIn,
    required this.totalsnowCm,
    required this.avgvisKm,
    required this.avgvisMiles,
    required this.avghumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
    required this.airQuality,
  });

  ///Maximum temperature in celsius for the day.
  double maxtempC;

  ///Maximum temperature in fahrenheit for the day
  double maxtempF;

  ///Minimum temperature in celsius for the day
  double mintempC;

  ///Minimum temperature in fahrenheit for the day
  double mintempF;

  ///Average temperature in celsius for the day
  double avgtempC;

  ///Average temperature in fahrenheit for the day
  double avgtempF;

  ///Maximum wind speed in miles per hour
  double maxwindMph;

  ///	Maximum wind speed in kilometer per hour
  double maxwindKph;

  ///Total precipitation in milimeter
  double totalprecipMm;

  ///Total precipitation in inches
  double totalprecipIn;

  ///Total snow in centimeters
  double totalsnowCm;

  ///Average visibility in kilometer
  int avgvisKm;

  ///Average visibility in miles
  int avgvisMiles;

  ///Average humidity as percentage
  int avghumidity;

  ///
  double dailyWillItRain;

  ///
  double dailyChanceOfRain;

  ///
  double dailyWillItSnow;

  ///
  double dailyChanceOfSnow;

  ///condition
  ConditionModel condition;

  ///UV Index
  double uv;

  ///airQuality
  AirQualityModel airQuality;

  factory DayModel.fromJson(Map<String, dynamic> json) => DayModel(
        maxtempC:
            json["maxtemp_c"] != null ? json["maxtemp_c"].toDouble() : 0.0,
        maxtempF:
            json["maxtemp_f"] != null ? json["maxtemp_f"].toDouble() : 0.0,
        mintempC:
            json["mintemp_c"] != null ? json["mintemp_c"].toDouble() : 0.0,
        mintempF:
            json["mintemp_f"] != null ? json["mintemp_f"].toDouble() : 0.0,
        avgtempC:
            json["avgtemp_c"] != null ? json["avgtemp_c"].toDouble() : 0.0,
        avgtempF:
            json["avgtemp_f"] != null ? json["avgtemp_f"].toDouble() : 0.0,
        maxwindMph:
            json["maxwind_mph"] != null ? json["maxwind_mph"].toDouble() : 0.0,
        maxwindKph:
            json["maxwind_kph"] != null ? json["maxwind_kph"].toDouble() : 0.0,
        totalprecipMm: json["totalprecip_mm"] != null
            ? json["totalprecip_mm"].toDouble()
            : 0.0,
        totalprecipIn: json["totalprecip_in"] != null
            ? json["totalprecip_in"].toDouble()
            : 0.0,
        totalsnowCm: json["totalsnow_cm"] != null
            ? json["totalsnow_cm"].toDouble()
            : 0.0,
        avgvisKm: json["avgvis_km"] ?? 0,
        avgvisMiles: json["avgvis_miles"] ?? 0,
        avghumidity: json["avghumidity"] ?? 0,
        dailyWillItRain: json["daily_will_it_rain"] != null
            ? json["daily_will_it_rain"].toDouble()
            : 0.0,
        dailyChanceOfRain: json["daily_chance_of_rain"] != null
            ? json["daily_chance_of_rain"].toDouble()
            : 0.0,
        dailyWillItSnow: json["daily_will_it_snow"] != null
            ? json["daily_will_it_snow"].toDouble()
            : 0.0,
        dailyChanceOfSnow: json["daily_chance_of_snow"] != null
            ? json["daily_chance_of_snow"].toDouble()
            : 0.0,
        condition: ConditionModel.fromJson(json["condition"]),
        uv: json["uv"] != null ? json["uv"].toDouble() : 0.0,
        airQuality: AirQualityModel.fromJson(json["air_quality"]),
      );

  Map<String, dynamic> toJson() => {
        "maxtemp_c": maxtempC,
        "maxtemp_f": maxtempF,
        "mintemp_c": mintempC,
        "mintemp_f": mintempF,
        "avgtemp_c": avgtempC,
        "avgtemp_f": avgtempF,
        "maxwind_mph": maxwindMph,
        "maxwind_kph": maxwindKph,
        "totalprecip_mm": totalprecipMm,
        "totalprecip_in": totalprecipIn,
        "totalsnow_cm": totalsnowCm,
        "avgvis_km": avgvisKm,
        "avgvis_miles": avgvisMiles,
        "avghumidity": avghumidity,
        "daily_will_it_rain": dailyWillItRain,
        "daily_chance_of_rain": dailyChanceOfRain,
        "daily_will_it_snow": dailyWillItSnow,
        "daily_chance_of_snow": dailyChanceOfSnow,
        "condition": condition.toJson(),
        "uv": uv,
        "air_quality": airQuality.toJson(),
      };
}
