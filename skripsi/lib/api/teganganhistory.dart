import 'package:http/http.dart' as http;
import 'package:skripsi/models/teganganhistory.dart';

Future<TeganganHistory> getTegangan1hour() async {
  var data1hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/tegangan/1hour"));
  final tegangan1hour = teganganHistoryFromJson(data1hour.body);

  return tegangan1hour;
}

Future<TeganganHistory> getTegangan3Hour() async {
  var data3hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/tegangan/3hour"));
  final tegangan3hour = teganganHistoryFromJson(data3hour.body);

  return tegangan3hour;
}

Future<TeganganHistory> getTegangan6Hour() async {
  var data6hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/tegangan/6hour"));
  final tegangan6hour = teganganHistoryFromJson(data6hour.body);

  return tegangan6hour;
}
