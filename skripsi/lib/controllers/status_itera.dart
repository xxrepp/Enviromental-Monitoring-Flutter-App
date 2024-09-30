import 'package:get/get.dart';
import 'package:skripsi/api/status_itera.dart';
import 'package:skripsi/models/status_itera.dart';

class StatusIteraController extends GetxController {
  var statusEhn = RxString("");
  var statusEhe = RxString("");
  var statusEhz = RxString("");

  @override
  void onInit() {
    super.onInit();
    // Panggil fungsi untuk mendapatkan data dari API saat Controller diinisialisasi
    fetchData();
  }

  // Fungsi untuk mendapatkan data dari API
  void fetchData() {
    Stream<List<StatusItera>> parameterStream = getStatusItera();

    parameterStream.listen((dataList) {
      if (dataList.isNotEmpty) {
        StatusItera data = dataList.first;

        statusEhe.value = data.statusEhe.toString();
        statusEhn.value = data.statusEhn.toString();
        statusEhz.value = data.statusEhz.toString();
      }
    }, onError: (err) {
      print('Error fetching data: $err');
    });
  }
}
