// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  /// Location name
  String name;

  /// Region or state of the location, if availa
  String region;

  /// Location country
  String country;

  /// Latitude in decimal degree(-90 to 90)
  double lat;

  /// Longitude in decimal degree(-180 to 180)
  double lon;

  /// Time zone name
  String tzId;

  /// Local date and time in unix time
  int localtimeEpoch;

  /// Local date and time
  String localtime;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"] ?? '',
        region: json["region"] ?? '',
        country: json["country"] ?? '',
        lat: json["lat"] != null ? json["lat"].toDouble() : -91.0,
        lon: json["lon"] != null ? json["lon"].toDouble() : -181.0,
        tzId: json["tz_id"] ?? '',
        localtimeEpoch: json["localtime_epoch"] ?? 0,
        localtime: json["localtime"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
        "tz_id": tzId,
        "localtime_epoch": localtimeEpoch,
        "localtime": localtime,
      };
}
