import 'package:get/get.dart';
import 'package:skripsi/api/parameter_itera.dart';
import 'package:skripsi/models/parameter_itera.dart';

class IteraController extends GetxController {
  var ehn = RxString("");
  var ehe = RxString("");
  var ehz = RxString("");

  @override
  void onInit() {
    super.onInit();
    // Panggil fungsi untuk mendapatkan data dari API saat Controller diinisialisasi
    getDataItera();
  }

  // Fungsi untuk mendapatkan data dari API
  void getDataItera() {
    Stream<List<ParameterItera>> parameterStream = getParameterItera();

    parameterStream.listen((dataList) {
      if (dataList.isNotEmpty) {
        DataItera data = dataList.first.data.first;

        ehe.value = data.nilaiEhe.toString();
        ehn.value = data.nilaiEhn.toString();
        ehz.value = data.nilaiEhz.toString();
      }
    }, onError: (err) {
      print('Error fetching data: $err');
    });
  }
}
