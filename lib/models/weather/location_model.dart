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

  String name;
  String region;
  String country;
  double lat;
  double lon;
  String tzId;
  int localtimeEpoch;
  String localtime;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"] ?? '',
        region: json["region"] ?? '',
        country: json["country"] ?? '',
        lat: json["lat"] != null ? json["lat"].toDouble() : 0,
        lon: json["lon"] != null ? json["lon"].toDouble() : 0,
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
