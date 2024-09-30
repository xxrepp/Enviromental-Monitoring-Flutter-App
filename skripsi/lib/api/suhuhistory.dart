import 'package:http/http.dart' as http;
import 'package:skripsi/models/suhuhistory.dart';

Future<SuhuHistory> getSuhu1Hour() async {
  var data1hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/suhu/1hour"));
  final suhu1hour = suhuHistoryFromJson(data1hour.body);

  return suhu1hour;
}

Future<SuhuHistory> getSuhu3Hour() async {
  var data3hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/suhu/3hour"));
  final suhu3hour = suhuHistoryFromJson(data3hour.body);

  return suhu3hour;
}

Future<SuhuHistory> getSuhu6Hour() async {
  var data6hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/suhu/6hour"));
  final suhu6hour = suhuHistoryFromJson(data6hour.body);

  return suhu6hour;
}
