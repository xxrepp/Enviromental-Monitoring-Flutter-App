import 'package:http/http.dart' as http;
import 'package:skripsi/models/kelembabanhistory.dart';

Future<KelembabanHistory> getKelembaban1Hour() async {
  var data1hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/kelembaban/1hour"));
  final kelembaban1hour = kelembabanHistoryFromJson(data1hour.body);

  return kelembaban1hour;
}

Future<KelembabanHistory> getKelembaban3Hour() async {
  var data3hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/kelembaban/3hour"));
  final kelembaban3hour = kelembabanHistoryFromJson(data3hour.body);

  return kelembaban3hour;
}

Future<KelembabanHistory> getKelembaban6Hour() async {
  var data6hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/kelembaban/6hour"));
  final kelembaban6hour = kelembabanHistoryFromJson(data6hour.body);

  return kelembaban6hour;
}
