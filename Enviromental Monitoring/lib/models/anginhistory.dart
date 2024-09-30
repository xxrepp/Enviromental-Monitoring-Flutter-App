// To parse this JSON data, do
//
//     final anginHistory = anginHistoryFromJson(jsonString);

import 'dart:convert';

AnginHistory anginHistoryFromJson(String str) =>
    AnginHistory.fromJson(json.decode(str));

String anginHistoryToJson(AnginHistory data) => json.encode(data.toJson());

class AnginHistory {
  List<DataAngin> data;

  AnginHistory({
    required this.data,
  });

  factory AnginHistory.fromJson(Map<String, dynamic> json) => AnginHistory(
        data: List<DataAngin>.from(
            json["data"].map((x) => DataAngin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataAngin {
  DateTime tanggal;
  double v1;

  DataAngin({
    required this.tanggal,
    required this.v1,
  });

  factory DataAngin.fromJson(Map<String, dynamic> json) => DataAngin(
        tanggal: DateTime.parse(json["tanggal"]),
        v1: json["v1"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal.toIso8601String(),
        "v1": v1,
      };
}
