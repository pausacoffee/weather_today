import 'package:meta/meta.dart';
import 'dart:convert';

import 'air_quality_model.dart';
import 'condition_model.dart';

class HourModel {
  HourModel({
    required this.timeEpoch,
    required this.time,
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
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.willItRain,
    required this.chanceOfRain,
    required this.willItSnow,
    required this.chanceOfSnow,
    required this.visKm,
    required this.visMiles,
    required this.gustMph,
    required this.gustKph,
    required this.uv,
    required this.airQuality,
  });

  ///Time as epoch
  int timeEpoch;

  ///Date and time
  String time;

  ///Temperature in celsius
  double tempC;

  ///Temperature in fahrenheit
  double tempF;

  ///1 = Yes 0 = No
  ///Whether to show day condition icon or night icon
  int isDay;

  ///
  ConditionModel condition;

  ///Maximum wind speed in miles per hour
  double windMph;

  ///aximum wind speed in kilometer per hour
  double windKph;

  ///Wind direction in degrees
  int windDegree;

  ///Wind direction as 16 point compass. e.g.: NSW
  String windDir;

  ///Pressure in millibars
  double pressureMb;

  ///Pressure in inches
  double pressureIn;

  ///Precipitation amount in millimeters
  double precipMm;

  ///Precipitation amount in inches
  double precipIn;

  ///Humidity as percentage
  int humidity;

  ///Cloud cover as percentage
  int cloud;

  ///Windchill temperature in celcius
  double feelslikeC;

  ///Windchill temperature in fahrenheit
  double feelslikeF;

  ///Windchill temperature in celcius
  double windchillC;

  ///Windchill temperature in fahrenheit
  double windchillF;

  ///Heat index in celcius
  double heatindexC;

  ///Heat index in fahrenheit
  double heatindexF;

  ///Dew point in celcius
  double dewpointC;

  ///Dew point in fahrenheit
  double dewpointF;

  ///1 = Yes 0 = No
  ///Will it will rain or not
  int willItRain;

  ///Chance of rain as percentage
  int chanceOfRain;

  ///1 = Yes 0 = No
  ///Will it snow or not
  int willItSnow;

  ///Chance of snow as percentage
  int chanceOfSnow;

  ///Visibility in kilometer
  double visKm;

  ///Visibility in miles
  double visMiles;

  ///Wind gust in miles per hour
  double gustMph;

  ///Wind gust in kilometer per hour
  double gustKph;

  ///UV Index
  double uv;

  ///
  AirQualityModel airQuality;

  factory HourModel.fromJson(Map<String, dynamic> json) => HourModel(
        timeEpoch: json["time_epoch"] ?? 0,
        time: json["time"] ?? 0,
        tempC: json["temp_c"] != null ? json["temp_c"].toDouble() : 0.0,
        tempF: json["temp_f"] != null ? json["temp_f"].toDouble() : 0.0,
        isDay: json["is_day"] ?? 0,
        condition: ConditionModel.fromJson(json["condition"]),
        windMph: json["wind_mph"] != null ? json["wind_mph"].toDouble() : 0.0,
        windKph: json["wind_kph"] != null ? json["wind_kph"].toDouble() : 0.0,
        windDegree: json["wind_degree"] ?? 0,
        windDir: json["wind_dir"] ?? 0,
        pressureMb:
            json["pressure_mb"] != null ? json["pressure_mb"].toDouble() : 0.0,
        pressureIn:
            json["pressure_in"] != null ? json["pressure_in"].toDouble() : 0.0,
        precipMm:
            json["precip_mm"] != null ? json["precip_mm"].toDouble() : 0.0,
        precipIn:
            json["precip_in"] != null ? json["precip_in"].toDouble() : 0.0,
        humidity: json["humidity"] ?? 0,
        cloud: json["cloud"] ?? 0,
        feelslikeC:
            json["feelslike_c"] != null ? json["feelslike_c"].toDouble() : 0.0,
        feelslikeF:
            json["feelslike_f"] != null ? json["feelslike_f"].toDouble() : 0.0,
        windchillC:
            json["windchill_c"] != null ? json["windchill_c"].toDouble() : 0.0,
        windchillF:
            json["windchill_f"] != null ? json["windchill_f"].toDouble() : 0.0,
        heatindexC:
            json["heatindex_c"] != null ? json["heatindex_c"].toDouble() : 0.0,
        heatindexF:
            json["heatindex_f"] != null ? json["heatindex_f"].toDouble() : 0.0,
        dewpointC:
            json["dewpoint_c"] != null ? json["dewpoint_c"].toDouble() : 0.0,
        dewpointF:
            json["dewpoint_f"] != null ? json["dewpoint_f"].toDouble() : 0.0,
        willItRain: json["will_it_rain"] ?? 0,
        chanceOfRain: json["chance_of_rain"] ?? 0,
        willItSnow: json["will_it_snow"] ?? 0,
        chanceOfSnow: json["chance_of_snow"] ?? 0,
        visKm: json["vis_km"] != null ? json["vis_km"].toDouble() : 0.0,
        visMiles:
            json["vis_miles"] != null ? json["vis_miles"].toDouble() : 0.0,
        gustMph: json["gust_mph"] != null ? json["gust_mph"].toDouble() : 0.0,
        gustKph: json["gust_kph"] != null ? json["gust_kph"].toDouble() : 0.0,
        uv: json["uv"] != null ? json["uv"].toDouble() : 0.0,
        airQuality: AirQualityModel.fromJson(json["air_quality"]),
      );

  Map<String, dynamic> toJson() => {
        "time_epoch": timeEpoch,
        "time": time,
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
        "windchill_c": windchillC,
        "windchill_f": windchillF,
        "heatindex_c": heatindexC,
        "heatindex_f": heatindexF,
        "dewpoint_c": dewpointC,
        "dewpoint_f": dewpointF,
        "will_it_rain": willItRain,
        "chance_of_rain": chanceOfRain,
        "will_it_snow": willItSnow,
        "chance_of_snow": chanceOfSnow,
        "vis_km": visKm,
        "vis_miles": visMiles,
        "gust_mph": gustMph,
        "gust_kph": gustKph,
        "uv": uv,
        "air_quality": airQuality.toJson(),
      };
}
