// To parse this JSON data, do
//
//     final getaranHistory = getaranHistoryFromJson(jsonString);

import 'dart:convert';

GetaranHistory getaranHistoryFromJson(String str) =>
    GetaranHistory.fromJson(json.decode(str));

String getaranHistoryToJson(GetaranHistory data) => json.encode(data.toJson());

class GetaranHistory {
  String message;
  List<DataGetaran> data;

  GetaranHistory({
    required this.message,
    required this.data,
  });

  factory GetaranHistory.fromJson(Map<String, dynamic> json) => GetaranHistory(
        message: json["message"],
        data: List<DataGetaran>.from(
            json["data"].map((x) => DataGetaran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataGetaran {
  DateTime waktu;
  int nilaiEhe;
  int nilaiEhn;
  int nilaiEhz;

  DataGetaran({
    required this.waktu,
    required this.nilaiEhe,
    required this.nilaiEhn,
    required this.nilaiEhz,
  });

  factory DataGetaran.fromJson(Map<String, dynamic> json) => DataGetaran(
        waktu: DateTime.parse(json["waktu"]),
        nilaiEhe: json["nilai_ehe"],
        nilaiEhn: json["nilai_ehn"],
        nilaiEhz: json["nilai_ehz"],
      );

  Map<String, dynamic> toJson() => {
        "waktu": waktu.toIso8601String(),
        "nilai_ehe": nilaiEhe,
        "nilai_ehn": nilaiEhn,
        "nilai_ehz": nilaiEhz,
      };
}
