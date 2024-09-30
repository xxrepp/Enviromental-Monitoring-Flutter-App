import 'package:http/http.dart' as http;
import 'package:skripsi/models/getaranhistory.dart';

Future<GetaranHistory> getGetaran1Hour() async {
  var data1hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/getaran/1hour"));
  final getaran1hour = getaranHistoryFromJson(data1hour.body);

  return getaran1hour;
}

Future<GetaranHistory> getGetaran3Hour() async {
  var data3hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/getaran/3hour"));
  final getaran3hour = getaranHistoryFromJson(data3hour.body);

  return getaran3hour;
}

Future<GetaranHistory> getGetaran6Hour() async {
  var data6hour =
      await http.get(Uri.parse("http://103.3.46.200:3000/getaran/6hour"));
  final getaran6hour = getaranHistoryFromJson(data6hour.body);

  return getaran6hour;
}
