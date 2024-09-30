import 'package:get/get.dart';
import 'package:skripsi/api/parameter_unila.dart';
import 'package:skripsi/models/parameter_unila.dart';

class UnilaController extends GetxController {
  var suhu = RxString("");
  var kelembaban = RxString("");
  var angin = RxString("");
  var tegangan = RxString("");

  @override
  void onInit() {
    super.onInit();
    // Panggil fungsi untuk mendapatkan data dari API saat Controller diinisialisasi
    getDataUnila();
  }

  // Fungsi untuk mendapatkan data dari API
  void getDataUnila() {
    Stream<List<ParameterUnila>> parameterStream = getParameterUnila();

    parameterStream.listen((dataList) {
      if (dataList.isNotEmpty) {
        DataUnila data = dataList.first.data.first;

        suhu.value = data.suhu.toString();
        kelembaban.value = data.kelembapan.toString();
        angin.value = data.f1.toString();
        tegangan.value = data.v1.toString();
      }
    }, onError: (err) {
      print('Error fetching data: $err');
    });
  }
}
