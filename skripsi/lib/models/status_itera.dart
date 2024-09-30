// To parse this JSON data, do
//
//     final statusItera = statusIteraFromJson(jsonString);

import 'dart:convert';

StatusItera statusIteraFromJson(String str) =>
    StatusItera.fromJson(json.decode(str));

String statusIteraToJson(StatusItera data) => json.encode(data.toJson());

class StatusItera {
  String message;
  String statusEhn;
  String statusEhe;
  String statusEhz;
  List<StatusDataItera> latestData;

  StatusItera({
    required this.message,
    required this.statusEhn,
    required this.statusEhe,
    required this.statusEhz,
    required this.latestData,
  });

  factory StatusItera.fromJson(Map<String, dynamic> json) => StatusItera(
        message: json["message"],
        statusEhn: json["statusEhn"],
        statusEhe: json["statusEhe"],
        statusEhz: json["statusEhz"],
        latestData: List<StatusDataItera>.from(
            json["latestData"].map((x) => StatusDataItera.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusEhn": statusEhn,
        "statusEhe": statusEhe,
        "statusEhz": statusEhz,
        "latestData": List<dynamic>.from(latestData.map((x) => x.toJson())),
      };
}

class StatusDataItera {
  int id;
  DateTime waktu;
  int nilaiEhe;
  int nilaiEhz;
  int nilaiEhn;

  StatusDataItera({
    required this.id,
    required this.waktu,
    required this.nilaiEhe,
    required this.nilaiEhz,
    required this.nilaiEhn,
  });

  factory StatusDataItera.fromJson(Map<String, dynamic> json) =>
      StatusDataItera(
        id: json["id"],
        waktu: DateTime.parse(json["waktu"]),
        nilaiEhe: json["nilai_ehe"],
        nilaiEhz: json["nilai_ehz"],
        nilaiEhn: json["nilai_ehn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "waktu": waktu.toIso8601String(),
        "nilai_ehe": nilaiEhe,
        "nilai_ehz": nilaiEhz,
        "nilai_ehn": nilaiEhn,
      };
}
