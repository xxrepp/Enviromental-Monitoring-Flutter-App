// To parse this JSON data, do
//
//     final AllEvent = AllEventFromJson(jsonString);

import 'dart:convert';

AllEvent AllEventFromJson(String str) => AllEvent.fromJson(json.decode(str));

String AllEventToJson(AllEvent data) => json.encode(data.toJson());

class AllEvent {
  String message;
  List<DataEvent> data;

  AllEvent({
    required this.message,
    required this.data,
  });

  factory AllEvent.fromJson(Map<String, dynamic> json) => AllEvent(
        message: json["message"],
        data: List<DataEvent>.from(
            json["data"].map((x) => DataEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataEvent {
  int id;
  DateTime waktuEvent;
  String namaEvent;
  int nilaiEvent;

  DataEvent({
    required this.id,
    required this.waktuEvent,
    required this.namaEvent,
    required this.nilaiEvent,
  });

  factory DataEvent.fromJson(Map<String, dynamic> json) => DataEvent(
        id: json["id"],
        waktuEvent: DateTime.parse(json["waktu_event"]),
        namaEvent: json["nama_event"],
        nilaiEvent: json["nilai_event"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "waktu_event": waktuEvent.toIso8601String(),
        "nama_event": namaEvent,
        "nilai_event": nilaiEvent,
      };
}
