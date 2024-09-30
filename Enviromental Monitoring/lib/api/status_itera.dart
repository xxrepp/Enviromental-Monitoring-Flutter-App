import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:skripsi/models/status_itera.dart';

Stream<List<StatusItera>> getStatusItera() {
  return Stream.periodic(Duration(seconds: 1), (index) async {
    var dataResponse =
        await http.get(Uri.parse("http://103.3.46.200:3000/itera/status"));

    if (dataResponse.statusCode == 200) {
      var data = statusIteraFromJson(dataResponse.body);
      return [data];
    } else {
      throw Exception('Failed to load data');
    }
  }).asyncMap((event) => event);
}
