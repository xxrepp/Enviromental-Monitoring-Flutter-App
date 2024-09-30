import 'package:get/get.dart';
import 'package:skripsi/api/status_unila.dart';
import 'package:skripsi/models/status_unila.dart';

class StatusUnilaController extends GetxController {
  var statusKelembaban = RxString("");
  var statusAngin = RxString("");
  var statusSuhu = RxString("");
  var statusTegangan = RxString("");

  @override
  void onInit() {
    super.onInit();
    // Panggil fungsi untuk mendapatkan data dari API saat Controller diinisialisasi
    fetchData();
  }

  // Fungsi untuk mendapatkan data dari API
  void fetchData() {
    Stream<List<StatusUnila>> parameterStream = getStatusUnila();

    parameterStream.listen((dataList) {
      if (dataList.isNotEmpty) {
        StatusUnila data = dataList.first;

        statusKelembaban.value = data.statusKelembaban.toString();
        statusAngin.value = data.statusAngin.toString();
        statusSuhu.value = data.statusSuhu.toString();
        statusTegangan.value = data.statusTegangan.toString();
      }
    }, onError: (err) {
      print('Error fetching data: $err');
    });
  }
}
