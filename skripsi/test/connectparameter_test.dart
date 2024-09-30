import 'package:flutter_test/flutter_test.dart';
import 'package:skripsi/controllers/unila_controller.dart';
import 'package:skripsi/controllers/itera_controller.dart';

void main() {
  group('Dashboard Controller Test', () {
    group('Dashbord Unila', () {
      late UnilaController unilaController;

      setUp(() {
        unilaController = UnilaController();
      });

      test('Dashboard Unila', () {
        // Panggil fungsi untuk mendapatkan data dari API
        unilaController.getDataUnila();

        // Periksa bahwa nilai-nilai yang diperbarui dalam controller tidak bernilai null
        expect(unilaController.suhu.value, isNotNull);
        expect(unilaController.kelembaban.value, isNotNull);
        expect(unilaController.angin.value, isNotNull);
        expect(unilaController.tegangan.value, isNotNull);
      });
    });
    group('Dashbord Unila', () {
      late IteraController iteraController;

      setUp(() {
        iteraController = IteraController();
      });

      test('Dashboard Itera', () {
        // Panggil fungsi untuk mendapatkan data dari API
        iteraController.getDataItera();

        // Periksa bahwa nilai-nilai yang diperbarui dalam controller tidak bernilai null
        expect(iteraController.ehe.value, isNotNull);
        expect(iteraController.ehn.value, isNotNull);
        expect(iteraController.ehz.value, isNotNull);
      });
    });
  });
}
