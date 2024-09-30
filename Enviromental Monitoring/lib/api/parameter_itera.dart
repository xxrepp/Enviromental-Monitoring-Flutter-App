import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:skripsi/models/parameter_itera.dart';

Stream<List<ParameterItera>> getParameterItera() {
  return Stream.periodic(Duration(seconds: 1), (index) async {
    var dataResponse =
        await http.get(Uri.parse("http://103.3.46.200:3000/itera/latestdata"));

    if (dataResponse.statusCode == 200) {
      var data = parameterIteraFromJson(dataResponse.body);
      return [data];
    } else {
      throw Exception('Failed to load data');
    }
  }).asyncMap((event) => event);
}
