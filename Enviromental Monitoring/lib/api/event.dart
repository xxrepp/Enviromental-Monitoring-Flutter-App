import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:skripsi/models/event.dart';

Stream<List<AllEvent>> getEvent() {
  return Stream.periodic(Duration(seconds: 1), (index) async {
    var dataResponse = await http.get(Uri.parse("http://10.0.2.2:3000/event"));

    if (dataResponse.statusCode == 200) {
      var data = AllEventFromJson(dataResponse.body);
      return [data];
    } else {
      throw Exception('Failed to load data');
    }
  }).asyncMap((event) => event);
}
