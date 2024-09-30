// To parse this JSON data, do
//
//     final statusUnila = statusUnilaFromJson(jsonString);

import 'dart:convert';

StatusUnila statusUnilaFromJson(String str) =>
    StatusUnila.fromJson(json.decode(str));

String statusUnilaToJson(StatusUnila data) => json.encode(data.toJson());

class StatusUnila {
  String message;
  String statusAngin;
  String statusKelembaban;
  String statusSuhu;
  String statusTegangan;
  List<StatusDataUnila> latestData;

  StatusUnila({
    required this.message,
    required this.statusAngin,
    required this.statusKelembaban,
    required this.statusSuhu,
    required this.statusTegangan,
    required this.latestData,
  });

  factory StatusUnila.fromJson(Map<String, dynamic> json) => StatusUnila(
        message: json["message"],
        statusAngin: json["statusAngin"],
        statusKelembaban: json["statusKelembaban"],
        statusSuhu: json["statusSuhu"],
        statusTegangan: json["statusTegangan"],
        latestData: List<StatusDataUnila>.from(
            json["latestData"].map((x) => StatusDataUnila.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusAngin": statusAngin,
        "statusKelembaban": statusKelembaban,
        "statusSuhu": statusSuhu,
        "statusTegangan": statusTegangan,
        "latestData": List<dynamic>.from(latestData.map((x) => x.toJson())),
      };
}

class StatusDataUnila {
  int id;
  DateTime tanggal;
  int v1;
  double p1;
  int kelembapan;
  int suhu;
  double f1;

  StatusDataUnila({
    required this.id,
    required this.tanggal,
    required this.v1,
    required this.p1,
    required this.kelembapan,
    required this.suhu,
    required this.f1,
  });

  factory StatusDataUnila.fromJson(Map<String, dynamic> json) =>
      StatusDataUnila(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        v1: json["v1"],
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
