import 'package:weather_today/models/weather/astro_model.dart';
import 'package:weather_today/models/weather/hour_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'day_model.dart';

class Forecastday {
  Forecastday({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  String date;
  int dateEpoch;
  DayModel day;
  AstroModel astro;
  List<HourModel> hour;

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
        date: json["date"] ?? '',
        dateEpoch: json["date_epoch"],
        day: DayModel.fromJson(json["day"]),
        astro: AstroModel.fromJson(json["astro"]),
        hour: json["hour"] != null
            ? List<HourModel>.from(
                json["hour"].map((x) => HourModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "date_epoch": dateEpoch,
        "day": day.toJson(),
        "astro": astro.toJson(),
        "hour": List<dynamic>.from(hour.map((x) => x.toJson())),
      };
}
