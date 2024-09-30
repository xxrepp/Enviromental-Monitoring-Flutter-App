// To parse this JSON data, do
//
//     final parameterItera = parameterIteraFromJson(jsonString);

import 'dart:convert';

ParameterItera parameterIteraFromJson(String str) =>
    ParameterItera.fromJson(json.decode(str));

String parameterIteraToJson(ParameterItera data) => json.encode(data.toJson());

class ParameterItera {
  String message;
  List<DataItera> data;

  ParameterItera({
    required this.message,
    required this.data,
  });

  factory ParameterItera.fromJson(Map<String, dynamic> json) => ParameterItera(
        message: json["message"],
        data: List<DataItera>.from(
            json["data"].map((x) => DataItera.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataItera {
  int id;
  DateTime waktu;
  int nilaiEhe;
  int nilaiEhz;
  int nilaiEhn;

  DataItera({
    required this.id,
    required this.waktu,
    required this.nilaiEhe,
    required this.nilaiEhz,
    required this.nilaiEhn,
  });

  factory DataItera.fromJson(Map<String, dynamic> json) => DataItera(
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
