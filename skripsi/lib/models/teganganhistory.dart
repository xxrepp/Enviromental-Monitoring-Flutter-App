// To parse this JSON data, do
//
//     final teganganHistory = teganganHistoryFromJson(jsonString);

import 'dart:convert';

TeganganHistory teganganHistoryFromJson(String str) =>
    TeganganHistory.fromJson(json.decode(str));

String teganganHistoryToJson(TeganganHistory data) =>
    json.encode(data.toJson());

class TeganganHistory {
  String message;
  List<DataTegangan> data;

  TeganganHistory({
    required this.message,
    required this.data,
  });

  factory TeganganHistory.fromJson(Map<String, dynamic> json) =>
      TeganganHistory(
        message: json["message"],
        data: List<DataTegangan>.from(
            json["data"].map((x) => DataTegangan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataTegangan {
  DateTime tanggal;
  double f1;

  DataTegangan({
    required this.tanggal,
    required this.f1,
  });

  factory DataTegangan.fromJson(Map<String, dynamic> json) => DataTegangan(
        tanggal: DateTime.parse(json["tanggal"]),
        f1: json["f1"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal.toIso8601String(),
        "f1": f1,
      };
}
