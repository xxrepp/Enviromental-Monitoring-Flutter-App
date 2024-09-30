// To parse this JSON data, do
//
//     final suhuHistory = suhuHistoryFromJson(jsonString);

import 'dart:convert';

SuhuHistory suhuHistoryFromJson(String str) =>
    SuhuHistory.fromJson(json.decode(str));

String suhuHistoryToJson(SuhuHistory data) => json.encode(data.toJson());

class SuhuHistory {
  String message;
  List<DataSuhu> data;

  SuhuHistory({
    required this.message,
    required this.data,
  });

  factory SuhuHistory.fromJson(Map<String, dynamic> json) => SuhuHistory(
        message: json["message"],
        data:
            List<DataSuhu>.from(json["data"].map((x) => DataSuhu.fromJson(x))),
      );

  get isNotEmpty => null;

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataSuhu {
  DateTime tanggal;
  int suhu;

  DataSuhu({
    required this.tanggal,
    required this.suhu,
  });

  factory DataSuhu.fromJson(Map<String, dynamic> json) => DataSuhu(
        tanggal: DateTime.parse(json["tanggal"]),
        suhu: json["suhu"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal.toIso8601String(),
        "suhu": suhu,
      };
}
