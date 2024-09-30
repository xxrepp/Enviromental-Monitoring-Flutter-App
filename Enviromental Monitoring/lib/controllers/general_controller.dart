import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:async';

class DateTimeController extends GetxController {
  var date = RxString("");
  var time = RxString("");

  @override
  void onInit() {
    super.onInit();
    updateDateTime();
    Timer.periodic(const Duration(seconds: 30), (_) {
      updateDateTime();
    });
  }

  // Fungsi untuk memperbarui nilai waktu dan tanggal
  void updateDateTime() {
    date.value = DateFormat.yMMMMEEEEd().format(DateTime.now());
    time.value = DateFormat("HH:mm").format(DateTime.now());
  }
}
