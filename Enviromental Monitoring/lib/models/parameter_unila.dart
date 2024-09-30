// To parse this JSON data, do
//
//     final parameterUnila = parameterUnilaFromJson(jsonString);

import 'dart:convert';

ParameterUnila parameterUnilaFromJson(String str) =>
    ParameterUnila.fromJson(json.decode(str));

String parameterUnilaToJson(ParameterUnila data) => json.encode(data.toJson());

class ParameterUnila {
  String message;
  List<DataUnila> data;

  ParameterUnila({
    required this.message,
    required this.data,
  });

  factory ParameterUnila.fromJson(Map<String, dynamic> json) => ParameterUnila(
        message: json["message"],
        data: List<DataUnila>.from(
            json["data"].map((x) => DataUnila.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataUnila {
  int id;
  DateTime tanggal;
  double v1;
  double p1;
  int kelembapan;
  int suhu;
  double f1;

  DataUnila({
    required this.id,
    required this.tanggal,
    required this.v1,
    required this.p1,
    required this.kelembapan,
    required this.suhu,
    required this.f1,
  });

  factory DataUnila.fromJson(Map<String, dynamic> json) => DataUnila(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        v1: json["v1"]?.toDouble(),
        p1: json["p1"]?.toDouble(),
        kelembapan: json["kelembapan"],
        suhu: json["suhu"],
        f1: json["f1"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal.toIso8601String(),
        "v1": v1,
        "p1": p1,
        "kelembapan": kelembapan,
        "suhu": suhu,
        "f1": f1,
      };
}
