// To parse this JSON data, do
//
//     final kelembabanHistory = kelembabanHistoryFromJson(jsonString);

import 'dart:convert';

KelembabanHistory kelembabanHistoryFromJson(String str) =>
    KelembabanHistory.fromJson(json.decode(str));

String kelembabanHistoryToJson(KelembabanHistory data) =>
    json.encode(data.toJson());

class KelembabanHistory {
  String message;
  List<DataKelembaban> data;

  KelembabanHistory({
    required this.message,
    required this.data,
  });

  factory KelembabanHistory.fromJson(Map<String, dynamic> json) =>
      KelembabanHistory(
        message: json["message"],
        data: List<DataKelembaban>.from(
            json["data"].map((x) => DataKelembaban.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataKelembaban {
  DateTime tanggal;
  int kelembapan;

  DataKelembaban({
    required this.tanggal,
    required this.kelembapan,
  });

  factory DataKelembaban.fromJson(Map<String, dynamic> json) => DataKelembaban(
        tanggal: DateTime.parse(json["tanggal"]),
        kelembapan: json["kelembapan"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal.toIso8601String(),
        "kelembapan": kelembapan,
      };
}
