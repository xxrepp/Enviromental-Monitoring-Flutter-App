import 'package:get/get.dart';
import 'package:skripsi/api/event.dart';
import 'package:skripsi/models/event.dart';

class EventController extends GetxController {
  var waktuEvent = RxList<String>();
  var jenisEvent = RxList<String>();
  var nilaiEvent = RxList<int>();

  @override
  void onInit() {
    super.onInit();
    getAllEvent(); // Panggil fungsi getAllEvent() saat controller diinisialisasi
  }

  Future<void> getAllEvent() async {
    try {
      List<AllEvent> dataList =
          await getEvent().first; // Ambil data pertama dari Stream

      if (dataList.isNotEmpty) {
        List<DataEvent> data =
            dataList[0].data; // Ambil data dari indeks pertama

        // Bersihkan data sebelum menambahkan data baru
        waktuEvent.clear();
        jenisEvent.clear();
        nilaiEvent.clear();

        // Ambil waktuEvent, namaEvent, dan nilaiEvent dari setiap DataEvent
        for (int i = 0; i < data.length; i++) {
          waktuEvent.add(data[i].waktuEvent.toString());
          jenisEvent.add(data[i].namaEvent);
          nilaiEvent.add(data[i].nilaiEvent);
        }
      }
    } catch (err) {
      print('Error fetching data: $err');
    }
  }
}
