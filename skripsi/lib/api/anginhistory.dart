import 'package:http/http.dart' as http;
import 'package:skripsi/models/anginhistory.dart';

Future<AnginHistory> getAngin1Hour() async {
  var data1hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/angin/1hour"));
  final angin1hour = anginHistoryFromJson(data1hour.body);

  return angin1hour;
}

Future<AnginHistory> getAngin3Hour() async {
  var data3hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/angin/3hour"));
  final angin3hour = anginHistoryFromJson(data3hour.body);

  return angin3hour;
}

Future<AnginHistory> getAngin6Hour() async {
  var data6hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/angin/6hour"));
  final angin6hour = anginHistoryFromJson(data6hour.body);

  return angin6hour;
}
