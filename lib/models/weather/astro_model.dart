import 'package:meta/meta.dart';
import 'dart:convert';

class AstroModel {
  AstroModel({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
    required this.isMoonUp,
    required this.isSunUp,
  });

  ///Sunrise time
  String sunrise;

  ///Sunset time
  String sunset;

  ///Moonrise time
  String moonrise;

  ///Moonset time
  String moonset;

  ///Moon phases. Value returned:
  ///New Moon
  ///Waxing Crescent
  ///First Quarter
  ///Waxing Gibbous
  ///Full Moon
  ///Waning Gibbous
  ///Last Quarter
  ///Waning Crescent
  String moonPhase;

  ///Moon illumination as %
  double moonIllumination;

  ///?? 1 = Yes 0 = No
  int isMoonUp;

  ///?? 1 = Yes 0 = No
  int isSunUp;

  factory AstroModel.fromJson(Map<String, dynamic> json) => AstroModel(
        sunrise: json["sunrise"] ?? '',
        sunset: json["sunset"] ?? '',
        moonrise: json["moonrise"] ?? '',
        moonset: json["moonset"] ?? '',
        moonPhase: json["moon_phase"] ?? '',
        moonIllumination: json["moon_illumination"] != null
            ? double.parse(json["moon_illumination"])
            : 0.0,
        isMoonUp: json["is_moon_up"] ?? 0,
        isSunUp: json["is_sun_up"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "moon_illumination": moonIllumination,
        "is_moon_up": isMoonUp,
        "is_sun_up": isSunUp,
      };
}
